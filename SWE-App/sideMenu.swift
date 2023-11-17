//
//  sideMenu.swift
//  SWE-App
//
//  Created by Alex on 11/2/23.
//

import SwiftUI

struct sideMenu: View {
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
//    @State private var textColor = "black"

    var body: some View {
        VStack{
            Text("**Menu**") //bold font
                .font(.title)
                .padding([.top], 100) //move everything down from the top
                .foregroundColor(.black)

            Divider() //horizontal bar
                .frame(width: 180, height: 4)
                .background(Color.black)
                .padding(.horizontal, 16)
            // MARK: - Content
            
            NavigationLink(destination: HomeScreenView()) { Text("Home")}
                .frame(width: 180, height: 50)
                .font(.system(size: 20, design: .rounded))
                .background(Color.customPurple)
                .cornerRadius(10)
                .foregroundColor(.black)
            
            NavigationLink(destination: DirectoryView()) {
                //take to directory
                Text("Directory")
            }
            .frame(width: 180, height: 50)
            .font(.system(size: 20, design: .rounded))
            .background(Color.customPurple)
            .cornerRadius(10)
            .foregroundColor(.black)
            
            NavigationLink(destination: CreateEventView()) {
                //take to admin view
                Text("Create Event")
            }
            .frame(width: 180, height: 50)
            .font(.system(size: 20, design: .rounded))
            .background(Color.customPurple)
            .cornerRadius(10)
            .foregroundColor(.black)
            .disabled(!GlobalStatus.isAdmin)
            
//TODO: changedestination link
            NavigationLink(destination: ProfileView(profile: allProfiles[0])) {
                //take to profile
                Text("Profile")
            }
            .frame(width: 180, height: 50)
            .font(.system(size: 20, design: .rounded))
            .background(Color.customPurple)
            .cornerRadius(10)
            .foregroundColor(.black)
            
            NavigationLink(destination: UserFeedback()) {
                Text("App Feedback")
            }
            .frame(width: 180, height: 50)
            .font(.system(size: 20, design: .rounded))
            .background(Color.customPurple)
            .cornerRadius(10)
            .foregroundColor(.black)
            
            NavigationLink(destination: LoginView()) {
                Text("Log Out")
            }
            .frame(width: 180, height: 50)
            .font(.system(size: 20, design: .rounded))
            .background(Color.customPurple)
            .cornerRadius(10)
            .foregroundColor(.black)

            Spacer()

//            Link(destination: URL(string: "https://apple.com")!){
//                Text("Apple")
//            }
            .font(.title)
            .foregroundColor(.black)
            Spacer()
        }
        .padding(16)
        .background(Color.customYellow)
//        .background(Color(red: 213/255, green: 188/255, blue: 85/255))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    sideMenu()
}
