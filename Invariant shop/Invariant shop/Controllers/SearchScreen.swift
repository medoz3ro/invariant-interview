import SwiftUI

class SearchState: ObservableObject {
    @Published var searchText = ""
}

struct SearchScreen: View {
    @StateObject private var userModel = UserViewModel()
    @StateObject var userStore: UserStore = UserStore()
    @StateObject private var searchState = SearchState()
    @State private var searchResults: [User] = []
    
    var body: some View {
        ScrollView {
            VStack {
                TitleFindView()
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                SearchBar(text: $searchState.searchText, onSearch: performSearch)
                    .padding(.bottom, 24)
                if searchResults.isEmpty {
                    PeopleView()
                } else {
                    if searchState.searchText == "" {
                        Text("People you may know")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    ForEach(searchResults, id: \.self) { user in
                        ProfileFollowersView(fullName: user.fullName, username: user.username, initials: user.initials, showSignOutButton: false)
                            .padding(.bottom, 14)
                            .onTapGesture {
                                navigateToClickedUserView(userId: user.id)
                            }
                    }
                }
            }
            .padding(.horizontal, 24)
            .onChange(of: searchState.searchText) { searchText in
                performSearch()
            }
            .onAppear {
                userModel.getMe(token: userStore.userToken)
                performSearch()
            }
        }
    }
    
    func performSearch() {
        if searchState.searchText.isEmpty {
            // Perform search with a space in the background
            userModel.searchUsers(username: " ") { users in
                searchResults = users
            }
        } else {
            userModel.searchUsers(username: searchState.searchText) { users in
                searchResults = users
            }
        }
    }
    
    
    
    
    
    
    
    func navigateToClickedUserView(userId: String) {
        SwiftUI.NavigationLink(destination: ClickedUserView(userId: userId)) {
            EmptyView()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            Image("search_tab_unselected")
            TextField("Search", text: $text, onCommit: onSearch)
                .foregroundColor(.primary)
                .autocapitalization(.none)
        }
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .onAppear {
            
            text = "" // Set the initial search text to an empty string
        }
    }
}
