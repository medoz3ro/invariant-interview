//
//  TitleVIew.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//



import SwiftUI


struct TitleView: View {
    
    var body: some View {
        HStack(spacing: 5) {
            Image("shopi")
                .resizable()
                .frame(width: 40, height: 40)
            Text("Shopi")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("Text"))
            Spacer()
            
            }
        }
    }
struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
