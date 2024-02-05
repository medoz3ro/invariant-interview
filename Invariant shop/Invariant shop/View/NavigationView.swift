//
//  NavigationView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 05.02.2024..
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        HStack(){
            VStack(spacing : -35.0){
                Image("sort").resizable() // Make sure the image is resizable
                    .scaledToFit() // Preserve the aspect ratio of the image while scaling
                    .scaleEffect(0.2)
                Text("Sort")
            }
            
            VStack(spacing : -35.0){
                Image("plus").resizable() // Make sure the image is resizable
                    .scaledToFit() // Preserve the aspect ratio of the image while scaling
                    .scaleEffect(0.2)
                Text("Add")
            }
            
            VStack(spacing : -35.0){
                Image("notes").resizable() // Make sure the image is resizable
                    .scaledToFit() // Preserve the aspect ratio of the image while scaling
                    .scaleEffect(0.2)
                Text("Notes")
            }
            
        }
        
    }
}

#Preview {
    NavigationView()
}
