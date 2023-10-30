//
//  EventCheckIn.swift
//  SWE-App
//
//  Created by Alex Chan on 10/19/23.
//

import SwiftUI

struct EventCheckIn: View {
    
    //not suitable for rotation or scaling
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    
    @State private var code = ""
    

    
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
                    Text("Event Check-In")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 170)    //This needs to be fixed for spacing
                        .padding(.bottom, 30)
                    
                    //fix magic numbers later
                    Text("Event Code:")
                        .font(.system(size:25))

                        
                    
                    TextField("Code", text: $code)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)

                    Spacer()
                        .frame(height: 20)
                    

                    Button("Check-In") {
                        //process request and land on a confirmation window
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.customPurple)
                    .cornerRadius(10)
                    
// TODO: Change destination link once home screen is available.
                    NavigationLink(destination: HomeScreenView()) { Text("Back to Home Screen")}
                        .frame(width: 300, height: 50)

                    
                }
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    EventCheckIn()
}

