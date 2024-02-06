//
//  NavigationView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 06.02.2024..
//

import SwiftUI


struct NavigationNotesView: View {

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "arrow.up.arrow.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.top, 20)
                
                Spacer()
                
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.top, 20)
                    
                
                Spacer()
                
                Image("list").resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.top, 20)
                
                Spacer()
            }
            .padding(.vertical)
            .frame(height: 40)
        }
        .background(Color.white)
        .shadow(color: .gray, radius: 1)
    }
}



struct NavigationNotesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationNotesView()
    }
}




