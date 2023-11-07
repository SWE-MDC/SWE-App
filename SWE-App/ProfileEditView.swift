//
//  ProfileEditView.swift
//  SWE-App
//
//  Created by Becca Pratel on 11/5/23.
//

import SwiftUI

struct ProfileEditView: View {
    
    /* Note: currently not allowing changing email
     because I don't know if that would mess up
     registration/creating account database stuff */
    @State private var name = ""
    @State private var pronouns = ""
    @State private var major = ""
    @State private var year = ""
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack() {
                    /*
                     Need to figure out how to allow changing of avatar/profile picture
                     */
                    Text("Edit Profile Information")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    TextField("Updated name:", text: $name)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Updated pronouns:", text: $pronouns)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Updated major:", text: $major)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Updated year:", text: $year)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                    
                    Button("Submit"){
                        //updates profile info in the database
                    }.foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.customPurple)
                        .cornerRadius(10)
                    
                    /* Allows naviagtion back to profile screen with or without submitting new profile info */
                    NavigationLink(destination: ProfileView(profile: allProfiles[0])) { Text("Back to Profile Screen")}
                        .frame(width: 300, height: 50)
                } //end VStack
                //used to display side bar menu
                //put inside zstack
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        sideMenu()
                        //hides the side menu with showMenu is false
                        .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                        .animation(.easeInOut(duration: 0.3), value: showMenu)
                    }
                }
                //when side menu is open, it darkens the rest of the screen
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            }//end ZStack
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//            .navigationTitle("Menu:")
//            .navigationBarTitleDisplayMode(.inline) //lines title up with icon


            .toolbar{
                
                Button{
                    //allows user to toggle the menu side bar
                    self.showMenu.toggle()
                } label: {
                    //if side menu is showing, display an "x" icon
                    if showMenu {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.black)
                    } else { //side menu not showing, show 3 bars
                        Image(systemName: "text.justify")
                            .font(.title)
                            .foregroundColor(Color.customYellow)
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    ProfileEditView()
    //ProfileEditView(profile: allProfiles[0])
}
