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
                        .frame(height: 200)
                    
                    
                    //fix magic numbers later
                    Text("Email")
                        .font(.system(size:25))

                        
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .textInputAutocapitalization(.never)
                        .cornerRadius(10)

                    Spacer()
                        .frame(height: 20)
                    
                    Text("Username")
                        .font(.system(size:25))

                        
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .textInputAutocapitalization(.never)
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
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Button("Register") {
                        if password != confirmPassword {
                            print("password does not match with the confirm password")
                        } else {
                            signup(email: email, username: username, password: password)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: ContentView()) { Text("Back to Login")}
                        .frame(width: 300, height: 50)
                    
                } //vstack
            } //zstack
            .ignoresSafeArea(.keyboard)
        }
    }
    
    func signup(email: String,
                username: String,
                password: String) {
        var error_msg = ""
        let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore

        // prepare json data
        let json: [String: Any] = ["email": email,
                                   "username": username,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: HttpResources.url_signup)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // insert json data to the request
        request.httpBody = jsonData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let status = responseJSON["status"] as! Int
                let msg = responseJSON["message"] as! String
                print(responseJSON)
                if status == 200 {
                    print("Signup successfully", msg)
                    // TODO Take user to the login screen
                } else {
                    error_msg = msg
                }
                semaphore.signal()
            }

        }


        task.resume()
        semaphore.wait()
        
        if error_msg == "" {
            print("Signup successfully")
        } else {
            print("Signup failed", error_msg)
            // TODO: Pop up an alert
        }

    }
}

#Preview {
    SignUpView()
}

