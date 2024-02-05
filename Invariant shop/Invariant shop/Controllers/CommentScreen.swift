import SwiftUI

struct CommentScreen: View {
    @State private var commentText: String = ""
    @State private var showComment: Bool = false
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    CommentsTextView()
                    if (showComment == true) {
                        CommentView(initials: "BS", username: "sabo", comment: "Bravo!")                    }
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            AddCommentView(initials: "BS", showComment: $showComment)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CommentScreen_Previews: PreviewProvider {
    static var previews: some View {
        CommentScreen()
    }
}
