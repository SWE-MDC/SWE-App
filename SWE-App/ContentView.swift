//
//  ContentView.swift
//  SWE
//
//  Created by Sam Weigman on 10/1/23.
//

import SwiftUI

//add in account sign up 

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    
    var body: some View {
        NavigationView {
            ZStack{

                Color.customPurple.ignoresSafeArea()
                Circle()
                    .offset(y: 120)
                    .scale(1.2)
                    .foregroundColor(.white)
               
                VStack {
                    Image("Logo")
                        .offset(y: -140)
                        .padding()
                    
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
                    
                    
                    NavigationLink(destination: SignUpView()) { Text("Create an account").padding(50)}
                    
                    NavigationLink(destination: HomeScreenView(), isActive: $showingLoginScreen) {
                    }
                                    
                    
                }
            }
        } .navigationBarHidden(true)
    }
    
    func authenticateUser(username: String, password: String) {
        //change later for our own database
        //use "usertest" as the fake username and "passtest" as the fake password
        if username.lowercased() == "usertest" {
            wrongUsername = 0
            if password.lowercased() == "passtest" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

#Preview {
    ContentView()
}
