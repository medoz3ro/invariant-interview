
import SwiftUI

struct NavigationView: View {
    @State var selection: Int = 0
    //  @ObservedObject var userStore = UserStore()
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        if (userStore.isLogged) {
            TabView(selection: $selection) {
                HomeScreen()
                    .navigationBarHidden(true)
                    .tag(0)
                    .tabItem {
                        Label {
                            Text("Home")
                        } icon: {
                            Image(selection == 0 ? "home_tab_selected" : "home_tab_unselected")
                                .foregroundColor(Color("dark4"))
                        }
                    }
                SearchScreen()
                    .navigationBarHidden(true)
                    .tag(1)
                    .tabItem {
                        Label {
                            Text("Search")
                        } icon: {
                            Image(selection == 1 ? "search_tab_selected" : "search_tab_unselected")
                                .foregroundColor(Color("dark4"))
                        }
                    }
                ProfileScreen()
                    .navigationBarHidden(true)
                    .tag(2)
                    .tabItem {
                        Label {
                            Text("Profile")
                        } icon: {
                            Image(selection == 2 ? "profile_tab_selected" :
                                    "profile_tab_unselected")
                            .foregroundColor(Color("dark4"))
                        }
                    }
            }
            .accentColor(Color("dark4"))
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
