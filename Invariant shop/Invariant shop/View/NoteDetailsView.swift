import SwiftUI

struct NoteDetailsView: View {
    let note: Note
    @ObservedObject private var dataManager = DataManager()
    private var linkedItems: [Item] {
        note.linkedItemIDs.compactMap { linkedItemID in
            dataManager.loadItems().first(where: { $0.id == linkedItemID })
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(note.title)
                .font(.title)
            
            if let content = note.note {
                Text(content)
                    .font(.body)
            }
            
            Text("Linked Items:")
                .font(.headline)
                .padding(.top)
            
            
            
            ScrollView {
                ForEach(linkedItems) { item in
                    ItemCardView(item: item)
                }
                .padding()
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Note Details", displayMode: .inline)
    }
}


extension NoteDetailsView {
    struct LinkedItemView: View {
        let linkedItemID: UUID
        @State private var linkedItemName: String = ""
        private let dataManager = DataManager()
        
        private var quantityFormatted: String {
            guard let linkedItem = dataManager.loadItems().first(where: { $0.id == linkedItemID }) else {
                return ""
            }
            return NumberFormatter.customAmountFormatter.string(from: NSNumber(value: linkedItem.quantity)) ?? "\(linkedItem.quantity)"
        }

        var body: some View {
            if let linkedItem = dataManager.loadItems().first(where: { $0.id == linkedItemID }) {
                HStack {
                    Text(linkedItem.name)
                        .textStyle()
                    Spacer()
                    Text("Quantity: \(quantityFormatted)")
                        .textStyle(font: .subheadline)
                }
               
                .padding(.vertical, 5)
            } else {
                Text("Linked item not found")
                    .textStyle()
                    .padding(.vertical, 5)
            }
        }
    }
}
