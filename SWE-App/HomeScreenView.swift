//
//  HomeScreenView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/10/23.
//

import SwiftUI
import UIKit

//NOT for admin use
//view future events? link to google calendar
//check into current event
//settings/view profile

struct HomeScreenView: View {
    
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    @State var menuOpened = false;
    @State var events: [Event] = []
    @State var eventsReady: Bool = false
    @State private var showMenu: Bool = false

    var body: some View {
        NavigationView{
            ZStack{
                Color.customPurple
                
                
//                HStack {
////TODO: hide this button for non admin users
//                    NavigationLink(destination: AdminView()) {
//                        Text("Create Event")
//                    }
//                    .frame(width: 120, height: 120, alignment: .leading)
//                    .font(.system(size: 28, design: .rounded)
//                        .weight(.bold))
//                    .foregroundColor(Color.white)
//                    .cornerRadius(10)
//                    .position(x: -50, y: height/2)
//                    
//                    
//                    NavigationLink(destination: LoginView()) {
//                        Text("Log Out")
//                    }
//                    
//                    .font(.system(size: 28, design: .rounded)
//                        .weight(.bold))
//                    .foregroundColor(Color.white)
//                    .cornerRadius(10)
//                    .position(x: 10, y: height/2)
//                    
//                    
//                  
//  
//                }
////                .frame(width: 120, height: 120, alignment: .trailing)
                
                VStack{
                    
//TODO: have this text change with the name of the current event either pulled from the database or entered manually by an admin

//                    Text("No Current Events")
//                        .multilineTextAlignment(.center)
//                        .font(.system(size: 50, design: .rounded)
//                            .weight(.heavy))
//                        .foregroundColor(Color.white)
//                        .position(x: width/2, y: height/3)
                    Button("Show Events")
                    {
                        eventsReady = false
                        getEvents()
                    }.foregroundColor(.customPurple)
                        .frame(width: 250, height: 50)
                        .font(.system(size: 20, design: .rounded))
                        .background(Color.white)
                        .cornerRadius(10).position(x: width/2, y: height/3)
                    
                    
                    NavigationLink(destination: EventListView(events: $events), isActive: $eventsReady) {
                    }
                    
                    NavigationLink(destination: EventCheckIn()) {
                        //take to event screen
                        Text("Check In")
                    }
                    .font(.system(size: 40, design: .rounded)
                        .weight(.bold))
                    .foregroundColor(Color.customPurple)
                    .frame(width: 250, height: 250)
                    .background(Color.white)
                    .cornerRadius(10)
                    .position(x: width/2, y: height/7)
                    
//                    HStack{
//                        NavigationLink(destination: EventView()) {
//                            Text("Future Events")
//                        }
//                        .font(.system(size: 20, design: .rounded)
//                            .weight(.bold))
//                        .foregroundColor(Color.customPurple)
//                        .frame(width: 120, height: 120)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        
//                        NavigationLink(destination: DirectoryView()) {
//                            //take to directory
//                            Text("Directory")
//                        }
//                        .font(.system(size: 20, design: .rounded)
//                            .weight(.bold))
//                        .foregroundColor(Color.customPurple)
//                        .frame(width: 120, height: 120)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .padding(0.4)
//                        
//                        
//                        Button("Profile") {
//                            //take to settings
//                        }
//                        .font(.system(size: 20, design: .rounded)
//                            .weight(.bold))
//                        .foregroundColor(Color.customPurple)
//                        .frame(width: 120, height: 120)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        
//                        
//                    } .padding()
                    
                }
                //used to display side bar menu
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        sideMenu()
                        //                                .offset(x: 0)
                        //                                .offset(x: UIScreen.main.bounds.width)
                            .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                            .animation(.easeInOut(duration: 0.3), value: showMenu)
                    }
                }
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            } .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .navigationTitle("Menu:")
                .navigationBarTitleDisplayMode(.inline)


                .toolbar{
                    
                    Button{
                        self.showMenu.toggle()
                    } label: {
                        
                        if showMenu {
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "text.justify")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                }
        } .navigationBarHidden(true)
            
    }

    func getEvents() {
        let semaphore = DispatchSemaphore(value: 0)
        let request = HttpResources.prepareGetRequest(s_url: HttpResources.url_list_events + "?limit=100", token: GlobalStatus.token)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                semaphore.signal()
                return
            }
            guard let eventResp = try?JSONDecoder().decode(EventResponse.self, from: data) else {
                print("Failed to parse json")
                semaphore.signal()
                return
            }
            
            if eventResp.status == 200 {
                events = eventResp.events
            }
            semaphore.signal()
            
        }


        task.resume()
        semaphore.wait()
        eventsReady = true
    }
}

#Preview {
    HomeScreenView()
}
