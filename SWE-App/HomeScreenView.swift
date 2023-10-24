//
//  HomeScreenView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/10/23.
//

import SwiftUI

//NOT for admin use
//view future events? link to google calendar
//check into current event
//settings/view profile

struct HomeScreenView: View {
    
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    @State var menuOpened = false;

    var body: some View {
        ZStack{
            Color.customPurple
            
            
            VStack{
                //change this to align with current event
                Text("No Current Events")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 50, design: .rounded)
                        .weight(.heavy))
                    .foregroundColor(Color.white)
                    .position(x: width/2, y: height/3)
                
                Button("Check In") {
                    //take to event screen
                }
                .font(.system(size: 40, design: .rounded)
                    .weight(.bold))
                .foregroundColor(Color.customPurple)
                .frame(width: 250, height: 250)
                .background(Color.white)
                .cornerRadius(10)
                .position(x: width/2, y: height/7)
                
                HStack{
                    Button("Calendar") {
                        //take to calendar
                    }
                    .font(.system(size: 20, design: .rounded)
                        .weight(.bold))
                    .foregroundColor(Color.customPurple)
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Button("Directory") {
                        //take to directory
                    }
                    .font(.system(size: 20, design: .rounded)
                        .weight(.bold))
                    .foregroundColor(Color.customPurple)
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(0.4)

                    
                    Button("Settings") {
                        //take to settings
                    }
                    .font(.system(size: 20, design: .rounded)
                        .weight(.bold))
                    .foregroundColor(Color.customPurple)
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    
                } .padding()

            }


        } .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }

}

#Preview {
    HomeScreenView()
}
