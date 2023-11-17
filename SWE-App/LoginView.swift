//
//  ContentView.swift
//  SWE
//
//  Created by Sam Weigman on 10/1/23.
//

import SwiftUI


//add in account sign up

struct LoginView: View {
    @State private var username = "geng.161@buckeyemail.osu.edu"
    @State private var password = "random_blabla1234"
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingHomeScreen = false
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    @State private var loginFailed = false;
    @State private var errorMsg = ""
    
    
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
                        
                    }.alert(errorMsg, isPresented: $loginFailed)
                    {
                        Button("OK", role: .cancel) { }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
                    
                    NavigationLink(destination: SignUpView()) { Text("Create an account").padding(15)
                    }
                    //                    Spacer()
                    //                        .frame(height: 0)
                    
                    NavigationLink(destination: ResetPassword()) { Text("Reset Password")}
                    Spacer()
                        .frame(height: 20)
                    

                    NavigationLink(destination: HomeScreenView(), isActive: $showingHomeScreen) {
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
        let request = HttpResources.preparePostRequest(s_url: HttpResources.url_login, json: json, token: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                errorMsg = error?.localizedDescription ?? "No data"
                semaphore.signal()
                return
            }
            
            do {
                 let resp = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                if resp.status == 200 {
                    wrongPassword = 0
                    showingHomeScreen = true
                    GlobalStatus.token = resp.token!
                    GlobalStatus.isAdmin = (resp.role!.name == "admin" || resp.role!.name == "organizer")
                    print(GlobalStatus.isAdmin)
                } else {
                    wrongPassword = 2
                    errorMsg = resp.message
                }
            } catch let error {
                errorMsg = "Parse error"
                print(error)
            }

            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        if errorMsg != "" {
            print("Sign in failed", errorMsg)
            loginFailed = true
        }
    }
}

#Preview {
    LoginView()
}
