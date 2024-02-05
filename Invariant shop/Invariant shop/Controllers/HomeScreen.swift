import SwiftUI

struct HomeScreen: View {
    @State var is_liked: Bool = false
    @State private var isCommentScreenPresented = false
    @StateObject var viewModel: FeedViewModel = FeedViewModel()
    @EnvironmentObject var userStore: UserStore
    @State private var isImageViewPresented = false
    
    var body: some View {
        SwiftUI.NavigationView {
            if (userStore.isLogged) {
                ScrollView {
                    VStack {
                        TitleView()
                            .padding(.top, 16)
                            .padding(.bottom, 24)
                        CheliActiveChallenge(viewModel: viewModel, isImageViewPresented: $isImageViewPresented)
                        MyFeedView()
                        
                        LazyVStack(spacing: 20) {
                            // start
                            ForEach(viewModel.feedItems, id: \.self) { item in
                                CheliItemView(icon: item.activeCheli.cheli.icon, title: item.activeCheli.cheli.title, finished: item.activeCheli.isCompleted, fullName: item.fullName, updatedAt: item.activeCheli.updatedAt, color: item.activeCheli.cheli.color, initials: item.initials, id: item.id, imageUrl: item.activeCheli.cheli.imageUrl)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .onAppear {
                        viewModel.fetchFeed(userToken: userStore.userToken)
                    }
                    .onChange(of: userStore.isLogged) { newValue in
                        if newValue == true {
                            print(userStore.userToken)
                            viewModel.fetchFeed(userToken: userStore.userToken)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CheliItemView(icon: String, title: String, finished: Bool, fullName: String, updatedAt: DateFormat, color: String, initials: String, id: String, imageUrl: String) -> some View {
        var prikaz = imageUrl == "hrasta" || imageUrl == "nikol" || imageUrl == "pata"
        VStack(alignment: .leading, spacing: 10){
            Button {
                isImageViewPresented = true
            } label: {
                Rectangle()
                    .fill(prikaz ? Color("grey500") : Color(hex: color))
                    .frame(height: prikaz ? 340 : 140)
                //.frame(height: 340)
                    .padding(.horizontal, -16)
                    .padding(.top, -16)
                //.padding(.horizontal, 0)
                //.padding(.top, 0)
                    .overlay {
                        if imageUrl == "hrasta" {
                            Image("retard")
                                .resizable()
                                .aspectRatio(contentMode: .fit) // Maintain aspect ratio

                        } else if imageUrl == "nikol" {
                            Image("retard2")
                                .resizable()
                                .aspectRatio(contentMode: .fit) // Maintain aspect ratio

                        } else if imageUrl == "pata" {
                            Image("retard3")
                                .resizable()
                        } else {
                            Text(icon)
                                .font(.system(size: 48))
                        }
                    }
            }
            .sheet(isPresented: $isImageViewPresented) {
                ImageView()
            }
            
            
            Text(title)
                .foregroundColor(Color("dark4"))
                .font(.system(size: 16, weight: .bold))
            
            HStack {
                Text(finished ? "Completed" : "Not completed")
                    .font(.system(size: 12))
                    .foregroundColor(Color("dark4").opacity(0.8))
                Spacer()
                Text(updatedAt.human)
                    .font(.system(size: 12))
                    .foregroundColor(Color("dark4"))
            }
            Divider()
            HStack {
                MemberView(id: id, fullName: fullName, initials: initials)
                Spacer()
                Button(action: {
                    //button action povezati sa apijem
                    is_liked.toggle()
                }) {
                    //promijeniti sliku na liked
                    Image(is_liked ? "like_selected" : "like")
                    
                }
                .padding(.trailing, 7)
                
                Button(action: {
                    isCommentScreenPresented = true
                }) {
                    Image("comment")
                }
                .sheet(isPresented: $isCommentScreenPresented) {
                    CommentScreen()
                }
            }
        }
        
        .modifier(ContainerViewModifier())
        .padding(.all, 0)
    }
}

func CheliActiveChallenge(viewModel: FeedViewModel, isImageViewPresented: Binding<Bool>) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                // TODO: Gradient
                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                .overlay(
                    Image("active_feed_background")
                )
                .frame(height: 250)
                .mask {
                    RoundedRectangle(cornerRadius: 16)
                }
                .overlay {
                    ActiveView(myCheli: viewModel.myCheli ?? CheliPost(data: [:]))
                        .padding(.horizontal, 28.0)
                        .padding(.top, 48.0)
                        .padding(.bottom, 42.0)
                }

            Button(action: {
                isImageViewPresented.wrappedValue = true
            }) {
                Image("Image")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.top, 16)
                    .padding(.trailing, 16)
            }
        }
        .sheet(isPresented: isImageViewPresented) {
            EmptyScreen()
        }
    }
    .padding(.top, 16) // Add padding if needed
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
