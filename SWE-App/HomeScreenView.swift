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

struct MenuContent: View {
    var body: some View {
        ZStack{
            
        }
        
    }
    
}


struct SideMenu: View {
    var body: some View {
        ZStack{
            
        }
        
    }
    
}



struct HomeScreenView: View {
    
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height

    var body: some View {
        ZStack{
            Button(action : {
                //openMenu
            }, label: {
                Text("Open Menu")
                    .frame(width: 300, height: 50)
                    .background(Color(.systemBlue))
            }
            )
            
        } .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HomeScreenView()
}
