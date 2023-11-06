//
//  ProfileView.swift
//  SWE-App
//
//  Created by Becca Pratel on 11/5/23.
//

import SwiftUI

struct ProfileView: View {
    
    let profile: ProfileInfo
    
    var body: some View {
        NavigationView{
            VStack() {
                Image(profile.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(150)
                    .shadow(radius: 3)
                
                
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
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    ProfileView(profile: allProfiles[0])
}
