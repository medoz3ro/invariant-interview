//
//  TitleVIew.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI


struct TitleView: View {
    var title: String
    
    var body: some View {
        VStack{
            HStack(spacing: 5) {
                Image("shopi")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Shopi")
                    .TitleModifier()
                Spacer()
                Text(title)
                    .padding()
                    .TitleModifier()
            }
            .background(Color("Title") .edgesIgnoringSafeArea(.all))
        }
        Spacer()
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "")
    }
}

