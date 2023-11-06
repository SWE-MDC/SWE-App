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
    
    var body: some View {
        NavigationView{
            VStack() {
                /* 
                 Need to figure out how to allow changing of avatar/profile picture
                 */
                Text("Edit Profile Information")
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
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    ProfileEditView()
    //ProfileEditView(profile: allProfiles[0])
}
