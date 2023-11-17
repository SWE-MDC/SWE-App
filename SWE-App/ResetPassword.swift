//
//  ResetPassword.swift
//  SWE-App
//
//  Created by Alex Chan on 10/17/23.
//

import SwiftUI

struct ResetPassword: View {
    
    //not suitable for rotation or scaling
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    
    @State private var email = ""
    @State private var resetSent: Bool = false
    @State private var resetError: Bool = false
    @State private var resetErrorMsg: String = ""

    
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
                
                
                VStack(alignment: .leading) {
//                    Spacer()
                    Text("Password Reset")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 170)    //This needs to be fixed for spacing
                        .padding(.bottom, 30)
                    
                    //fix magic numbers later
                    Text("Email")
                        .font(.system(size:25))
//                        .background(.red)

                        
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)

                    Spacer()
                        .frame(height: 20)
                    
                    Text("Note: Type in the email for the account you want to reset the password for. If account exists, an email will be sent to reset password.")
//                        .background(.red)
                        .frame(width: 300)
                    Spacer()
                        .frame(height: 50)
                    

                    Button("Send Reset Email") {
                        resetError = false
                        resetErrorMsg = ""
                        reset(email: email)
                    }
                    .alert(resetErrorMsg, isPresented: $resetError)
                    {
                        Button("OK", role: .cancel) { }
                    }
                    .disabled(resetSent)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
//                    Button("Go Back to Login") {
//                        NavigationLink(destination: HomeScreenView()) { Text("Reset Password")}
//                    }
//                    .frame(width: 300, height: 50)
                    NavigationLink(destination: LoginView(), isActive: $resetSent) { Text("Back to Login")}
                        .frame(width: 300, height: 50)

                    
                }
            }
        }.navigationBarHidden(true)
    }
    
    func reset(email:String) {
        let semaphore = DispatchSemaphore(value: 0)
        // prepare json data
        let request = HttpResources.prepareGetRequest(s_url: HttpResources.url_reset_password + "/" + email, token: "")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        semaphore.signal()
                        return
                    }
                    
                    do {
                        print(data)
                         let resp = try JSONDecoder().decode(GenericResponse.self, from: data)
                        if resp.status == 200 {
                            resetSent = true
                        } else
                        {
                            resetError = true
                            resetErrorMsg = resp.message
                        }
                        print(resp)
                    } catch let error {
                        print(error)
                    }

                    semaphore.signal()
                }
        task.resume()
        semaphore.wait()
    }
}

#Preview {
    ResetPassword()
}

