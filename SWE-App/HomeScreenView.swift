//
//  HomeScreenView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/10/23.
//

import SwiftUI

//NOT for admin use
//view future events? link to google calendar
//check into current event
//settings/view profile

struct HomeScreenView: View {
    
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    

    var body: some View {
        NavigationView {
            VStack {
                Button("Event Login") {
                    //take to event login
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 200)
                .background(Color.customPurple)
                .cornerRadius(30)
            }

        }
    }
}

#Preview {
    HomeScreenView()
}
