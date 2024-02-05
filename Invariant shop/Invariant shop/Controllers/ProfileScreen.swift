

import SwiftUI


struct ProfileScreen: View {
    @StateObject var userModel: UserViewModel = UserViewModel()
    @StateObject var viewModel: FeedViewModel = FeedViewModel()
    @EnvironmentObject var userStore : UserStore
    
    
    var body: some View {
        SwiftUI.NavigationView{
            ScrollView {
                VStack() {
                    TitleProfileView()
                        .padding(.top, 16)
                        .padding(.bottom, 24)
                    Image("profile_background")
                        .resizable()
                        .frame(height: 120)
                        .onAppear {
                            userModel.getMe(token: userStore.userToken)
                        }
                    ProfileFollowersView(fullName: userModel.myInfo.fullName, username: userModel.myInfo.username, initials: userModel.myInfo.initials, showFollowButton: false)
                        .padding(.top, 24)
                    CheliProfileFollowers(followingCount: userModel.myInfo.followingCount, followersCount: userModel.myInfo.followersCount, cheliPostsCount: userModel.myInfo.cheliPostsCount)
                    CheliView()
                    
                    ForEach(userModel.myInfo.cheliPosts, id: \.self ) { cheli in
                        
                        CheliAllCompletedcheliPosts(cheliItem: cheli)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    @ViewBuilder
    func CheliAllCompletedcheliPosts(cheliItem: CheliPost) -> some View {
        VStack() {
            Rectangle()
                .frame(height: 110)
                .foregroundColor(Color("bw"))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color ("grey200"), lineWidth: 2)
                )
                .overlay {
                    ProfileChallengeCompletedView(cheliItem: cheliItem)
                }
        }
    }
    
    @ViewBuilder
    //TODO Hardcoded width?
    func CheliProfileFollowers(followingCount: Int, followersCount: Int, cheliPostsCount: Int) -> some
    View {
        Divider()
        HStack() {
            VStack() {
                Text(String(cheliPostsCount))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text("Cheli's")
            }
            .padding(.horizontal, 12)
            Divider()
            //.padding(.horizontal, 12)
            VStack() {
                Text(String(userStore.followersCount))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text("Followers")
            }
            .padding(.horizontal, 12)
            Divider()
            //.padding(.horizontal, 12)
            VStack() {
                Text(String(followingCount))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text("Following")
            }
            .padding(.horizontal, 12)
        }
        Divider()
    }
}






struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
