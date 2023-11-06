//
//  UserFeedback.swift
//  SWE-App
//
//  Created by Alex on 11/2/23.
//

import SwiftUI
import Foundation
import UIKit



struct UserFeedback: View {
    @State private var otherComments = ""
    @State private var worksComments = ""
    @State private var notWorksComments = ""
    @State private var name = ""
    @State private var showMenu: Bool = false
    @State var menuOpened = false;


    //not suitable for rotation or scaling
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    
    @State private var email = ""
    

    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.customPurple)
                    .frame(width: width, height: 370, alignment: .top)
                    .ignoresSafeArea()
//                    .position(x: width/2, y: 0)
                    .position(x: width/2, y: 38)

                //                    .overlay(alignment: .bottom){
                //                        VStack(alignment: .leading, content: {
                //                            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                //                        })
                //                    }
                
                Image("Logo")
//                    .position(x: width/2, y: 70)
                    .position(x: width/2, y: 110)

                
                Text("User Feedback Form")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                    .position(x: width/2, y:240)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        TextField("Name:", text: $name)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        TextField("Email:", text: $email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        //                        HStack{
                        //                            Text("App Rating:")
                        //                            Menu("Select Option"){
                        //                                Button("Star", role: .destructive){
                        //                                    //do something
                        //                                }
                        //                                Button("Star",role: .destructive){
                        //                                    //
                        //                                }
                        //                            }
                        //                            .background(Color.black.opacity(0.05))
                        //                            .cornerRadius(5)
                        //                            .frame(width: 300, height: 40)
                        //                        }
                        
                        TextField("What works?", text: $worksComments, axis: .vertical)
                            .padding()
                            .frame(width: 300, height: 150)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        
                        TextField("What Doesn't Work?", text: $notWorksComments, axis: .vertical)
                            .padding()
                            .frame(width: 300, height: 150)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        TextField("Other Comments:", text: $otherComments, axis: .vertical)
                            .padding()
                            .frame(width: 300, height: 150)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                    } //end of vstack
                    
                    //button to submit the form
                    Button("Submit") {
                        //process request and land on a confirmation window
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
                    
                }// end of scroll view
                .frame(height:480) //height of the scroll window
                .position(x: width/2, y:510) // where the window is placed on screen
//                                .background(Color.red)
                
                //button to go to back to home screen
                NavigationLink(destination: HomeScreenView()) { Text("Back to Home")}
                    .frame(width: 300, height: 50)
                //formating where button will be
                    .position(x: width/2, y: 780)
                
                
                //used to display side bar menu
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
            } //end of zstack
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
                            .foregroundColor(.red)
                    } else { //side menu not showing, show 3 bars
                        Image(systemName: "text.justify")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    UserFeedback()
}

