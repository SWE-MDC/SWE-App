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
                    .position(x: width/2, y: 0)
//                    .overlay(alignment: .bottom){
//                        VStack(alignment: .leading, content: {
//                            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
//                        })
//                    }
                
                Image("Logo")
                    .position(x: width/2, y: 70)
                
                Text("User Feedback Form")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .bold()
                    .position(x: width/2, y:220)
                
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
                .frame(height:450) //height of the scroll window
                .position(x: width/2, y:470) // where the window is placed on screen
//                .background(Color.red)
                
                //button to go to back to home screen
                NavigationLink(destination: HomeScreenView()) { Text("Back to Home")}
                    .frame(width: 300, height: 50)
                //formating where button will be
                    .position(x: width/2, y: 729)
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    UserFeedback()
}

