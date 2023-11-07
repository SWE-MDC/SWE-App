//
//  ProfileView.swift
//  SWE-App
//
//  Created by Becca Pratel on 11/5/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State private var width = UIScreen.main.bounds.width

    let profile: ProfileInfo
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack() {
                    Image(profile.image)
                        .resizable()
//                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height:150)
//                        .clipped()
                        .cornerRadius(150)
                        .shadow(radius: 3)
                        .padding([.top], 80)
                    
                    
                    
                    Form {
                        HStack{
                            Text("Name")
                            Spacer()
                            Text(profile.name)
                        }
                        HStack{
                            Text("Email")
                            Spacer()
                            Text(profile.email)
                        }
                        HStack{
                            Text("Pronouns")
                            Spacer()
                            Text(profile.pronouns)
                        }
                        HStack{
                            Text("Major")
                            Spacer()
                            Text(profile.major)
                        }
                        HStack{
                            Text("Year")
                            Spacer()
                            Text(profile.year)
                        }
                    }
                    
                    NavigationLink(destination: ProfileEditView()) { Text("Edit Profile Information")}
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
            } //end ZStack
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
    ProfileView(profile: allProfiles[0])
}
