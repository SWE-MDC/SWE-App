//
//  SettingsView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/24/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack{
            Color.customPurple
            
            VStack{
                Text("Settings")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 50, design: .rounded)
                        .weight(.heavy))
                    .foregroundColor(Color.white)
                
                Button("Profile"){
                    
                }
                .font(.system(size: 20, design: .rounded)
                    .weight(.bold))
                .foregroundColor(Color.customPurple)
                .frame(width: 300, height: 120)
                .background(Color.white)
                .cornerRadius(10)
                
                Button("Log Out"){
                    
                }
                .font(.system(size: 20, design: .rounded)
                    .weight(.bold))
                .foregroundColor(Color.customPurple)
                .frame(width: 300, height: 120)
                .background(Color.white)
                .cornerRadius(10)
                
                
                
                
            }
        } .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    SettingsView()
}
