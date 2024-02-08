import SwiftUI

struct ItemPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var linkedItemIDs: [UUID] // IDs of linked items passed from the parent view

    @State private var filterText: String = ""
    @State private var items: [Item] = [] // This will be fetched from DataManager

    private let dataManager = DataManager()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Filter items by name", text: $filterText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                List {
                    ForEach(filteredItems, id: \.id) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            if linkedItemIDs.contains(item.id) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.toggleItemSelection(item: item)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Select Items", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                // Action to save the selected items or simply dismiss the view if saving is handled elsewhere
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                items = dataManager.loadItems()
            }
        }
    }

    private var filteredItems: [Item] {
        if filterText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.lowercased().contains(filterText.lowercased()) }
        }
    }

    private func toggleItemSelection(item: Item) {
        if let index = linkedItemIDs.firstIndex(of: item.id) {
            linkedItemIDs.remove(at: index)
        } else {
            linkedItemIDs.append(item.id)
        }
    }
}
