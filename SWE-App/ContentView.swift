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
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    @State private var loginFailed = false;
    @State private var errorMsg = ""
    @State private var token = ""
    
    
    var body: some View {
        NavigationView {
            ZStack{

                Color.customPurple.ignoresSafeArea()
                Circle()
                    .offset(y: 90)
                    .scale(1.2)
                    .foregroundColor(.white)
                Image("Logo")
                    .position(x: 180, y: 110)
                    .padding()
               
                VStack {
                    Spacer()
                        .frame(height: 200)
                    
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Email", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        loginFailed = false
                        errorMsg = ""
                        authenticateUser(username: username, password: password)
                    }.alert(errorMsg, isPresented: $loginFailed) {
                        Button("OK", role: .cancel) { }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
                    
                    NavigationLink(destination: SignUpView()) { Text("Create an account").padding(15)}
//                    Spacer()
//                        .frame(height: 0)
                    
                    NavigationLink(destination: ResetPassword()) { Text("Reset Password")}
                    Spacer()
                        .frame(height: 20)
                    
                    NavigationLink(destination: AdminView()) {
                        Text("ADMIN VIEW")
                    }

                    
                    NavigationLink(destination: HomeScreenView(), isActive: $showingLoginScreen) {
                    }

                    
                } //vstack


            } //zstack
            .ignoresSafeArea(.keyboard)

        } //nav view
        .navigationBarHidden(true)

    }
    
    func authenticateUser(username: String, password: String) {
        let semaphore = DispatchSemaphore(value: 0)
        // prepare json data
        let json: [String: Any] = ["usernameOrEmail": username,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: HttpResources.url_login)!
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
                    wrongPassword = 0
                    showingLoginScreen = true
                    token = responseJSON["token"] as! String
                } else {
                    wrongPassword = 2
                    errorMsg = msg
                }
                semaphore.signal()
            }
        }


        task.resume()
        semaphore.wait()
        if errorMsg == "" {
            print("Sign in successfully")
        } else {
            print("Sign in failed", errorMsg)
            loginFailed = true
        }
    }
}

#Preview {
    ContentView()
}
