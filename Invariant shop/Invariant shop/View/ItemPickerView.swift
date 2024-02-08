import SwiftUI

struct ItemPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var linkedItemIDs: [UUID] // IDs of linked items passed from the parent view

    @State private var filterText: String = ""
    @State private var items: [Item] = [] // This will be fetched from DataManager
    @State private var localLinkedItemIDs: [UUID] // Local copy to handle selections

    private let dataManager = DataManager()

    init(linkedItemIDs: Binding<[UUID]>) {
        self._linkedItemIDs = linkedItemIDs
        self._localLinkedItemIDs = State(initialValue: linkedItemIDs.wrappedValue)
    }

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
                            if localLinkedItemIDs.contains(item.id) {
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
                // Save the selections by updating the original binding
                self.linkedItemIDs = self.localLinkedItemIDs
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
        if let index = localLinkedItemIDs.firstIndex(of: item.id) {
            localLinkedItemIDs.remove(at: index)
        } else {
            localLinkedItemIDs.append(item.id)
        }
    }
}
