//
//  NavigationView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                VStack {
                    Image("sort").resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Sort")
                }
                .padding(.top, 20)
                
                Spacer()
                
                VStack {
                    Image("plus").resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Add")
                }
                .padding(.top, 20)
                
                Spacer()
                
                VStack {
                    Image("notes").resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Notes")
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding(.vertical)
            .frame(height: 50)
        }
        .background(Color.white)
        .shadow(color: .gray, radius: 1)
            
    }
}

#Preview {
    NavigationView()
}



