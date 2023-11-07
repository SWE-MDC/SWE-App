//
//  AdminView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/30/23.
//

import SwiftUI

struct AdminView: View {
    @State private var eventName = ""
//    @State private var eventDate = ""
    @State private var eventDetails = ""
    @State private var eventLocation = ""
    @State private var date = Date()
    @State var currentTime = Date()
    @State private var width = UIScreen.main.bounds.width
    @State private var showMenu: Bool = false
    @State var menuOpened = false;


    var closedRange = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    
    var body: some View {
        NavigationView{
        ZStack{
            Rectangle()
                .fill(Color.customPurple)
                .frame(width: width, height: 370, alignment: .top)
                .ignoresSafeArea()
//                    .position(x: width/2, y: 0)
                .position(x: width/2, y: 38)

            //                    .overlay(alignment: .bottom){
            //                        VStack(alignment: .leading, content: {
            //                            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
            //                        })
            //                    }
            
            Image("Logo")
//                    .position(x: width/2, y: 70)
                .position(x: width/2, y: 110)

        
            VStack() {
                //                VStack() {
                //                    Text("Admin View")
                //                        .frame(height: 50)
                //                        .background(Color.red)
                //
                
                
                VStack() {
                    Text("ADMIN VIEW")
                        .padding()
                    
                    NavigationLink(destination: AdminNewEvent()) { Text("Create New Event")}
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.customPurple)
                        .cornerRadius(10)
                    
                    NavigationLink(destination: AdminNewEvent()) { Text("View Reports. NOTE: still needs link")}
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.customPurple)
                        .cornerRadius(10)
                    
                    
                    //                        NavigationLink(destination: DirectoryView()) { Text("View Directory")}
                    //                            .foregroundColor(.white)
                    //                            .frame(width: 300, height: 50)
                    //                            .background(Color.customPurple)
                    //                            .cornerRadius(10)
                    //
                    //                        NavigationLink(destination: EventView()) { Text("View Events")}
                    //                            .foregroundColor(.white)
                    //                            .frame(width: 300, height: 50)
                    //                            .background(Color.customPurple)
                    //                            .cornerRadius(10)
                    
                    NavigationLink(destination: HomeScreenView()) { Text("Back to Home Screen")}
                        .frame(width: 300, height: 50)
                    
                    //                Section(header:Text("Result")){ //you can remove this
                    //                    Text("\(currentTime)")
                    //                }
                }
                //                }
            } //end vstack
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
        } //end z stack
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//        .navigationTitle("Menu:")
//        .navigationBarTitleDisplayMode(.inline) //lines title up with icon


        .toolbar{
            
            Button{
                //allows user to toggle the menu side bar
                self.showMenu.toggle()
            } label: {
                //if side menu is showing, display an "x" icon
                if showMenu {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.red)
                } else { //side menu not showing, show 3 bars
                    Image(systemName: "text.justify")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
        }
        }.navigationBarHidden(true)
    }
}

#Preview {
    AdminView()
}
