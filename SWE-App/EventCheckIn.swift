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
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State private var code = ""
    

    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.customPurple)
                    .frame(width: width, height: 370, alignment: .top)
                    .ignoresSafeArea()
//                    .position(x: width/2, y: 0)
                    .position(x: width/2, y: 38)
                
                Image("Logo")
//                    .position(x: width/2, y: 70)
                    .position(x: width/2, y: 110)
                
                
                VStack(alignment: .leading) {
                    Text("Event Check-In")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .bold()
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
                    
                    NavigationLink(destination: HomeScreenView()) { Text("Back to Home Screen")}
                        .frame(width: 300, height: 50)

                    
                }//end VStack
                //used to display side bar menu
                //put inside zstack
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        sideMenu()
                        //hides the side menu with showMenu is false
                        .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                        .animation(.easeInOut(duration: 0.3), value: showMenu)
                    }
                }
                //when side menu is open, it darkens the rest of the screen
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            }// end ZStack
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//            .navigationTitle("Menu:")
//            .navigationBarTitleDisplayMode(.inline) //lines title up with icon


            .toolbar{
                
                Button{
                    //allows user to toggle the menu side bar
                    self.showMenu.toggle()
                } label: {
                    //if side menu is showing, display an "x" icon
                    if showMenu {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.black)
                    } else { //side menu not showing, show 3 bars
                        Image(systemName: "text.justify")
                            .font(.title)
                            .foregroundColor(Color.customYellow)
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    EventCheckIn()
}

