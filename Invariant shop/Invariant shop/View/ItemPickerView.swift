import SwiftUI

struct ItemPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var linkedItemIDs: [UUID]
    @State private var filterText: String = ""
    @State private var items: [Item] = []
    @State private var localLinkedItemIDs: [UUID]
    
    private let dataManager = DataManager()
    
    init(linkedItemIDs: Binding<[UUID]>) {
        self._linkedItemIDs = linkedItemIDs
        self._localLinkedItemIDs = State(initialValue: linkedItemIDs.wrappedValue)
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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Filter items by name", text: $filterText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredItems, id: \.id) { item in
                            ItemCardView(item: item)
                                .padding(.horizontal)
                                .onTapGesture {
                                    self.toggleItemSelection(item: item)
                                }
                        }
                    }
                }
            }
            .navigationBarTitle("Select Items", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                self.linkedItemIDs = self.localLinkedItemIDs
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                items = dataManager.loadItems()
            }
        }
    }
}

struct ItemPickerCardView: View {
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.name)
                .font(.headline)
        }
        .cardStyle()
    }
}
