//
//  SignUpView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/10/23.
//

import SwiftUI

struct SignUpView: View {
    
    //not suitable for rotation or scaling
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""




    
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.customPurple)
                    .frame(width: width, height: 370, alignment: .top)
                    .ignoresSafeArea()
                    .position(x: width/2, y: 0)
                
                Image("Logo")
                    .position(x: width/2, y: 70)
                
                
                VStack(alignment: .leading) {
                    
                   Spacer()
                        .frame(height: 160)
                    
                    
                    //fix magic numbers later
                    Text("Email")
                        .font(.system(size:25))

                        
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)

                    Spacer()
                        .frame(height: 20)
                    
                    Text("Username")
                        .font(.system(size:25))

                        
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)

                    Spacer()
                        .frame(height: 20)
                    
                    //add logic to check password requirements
                    Text("Password")
                        .font(.system(size:25))
                    
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    
                    Spacer()
                        .frame(height: 20)
                    
                    
                    
                    //add in logic for confirming password
                    Text("Confirm Password")
                        .font(.system(size:25))

                    
                    TextField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    
                    if password != confirmPassword {
                        //passwords dont match
                    }
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Button("Continue") {
                        //take to demographic screen
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
                } //vstack
            } //zstack
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    SignUpView()
}

