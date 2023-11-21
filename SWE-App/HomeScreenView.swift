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
    @State var events: [Event] = []
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State var canAddEvent: Bool = false

    var body: some View {
        NavigationView{
            ZStack{
                Color.customPurple
                

                VStack{
                    List(events) {e in
                        EventRow(event: e)
                    }
                    .navigationTitle("Latest Events")
                    .frame(width: 350, height: 550)
                    .position(x: width/2, y: 450)


                    
                    NavigationLink(destination: LoginView()) {
                            Text("Log Out")
                        }
    
                        .font(.system(size: 28, design: .rounded)
                            .weight(.bold))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding([.bottom], 40)
                    
                }
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
            } //end of Zstack
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
        } 
        .navigationBarHidden(true)
        .task {
            do {
                let event = try await getEvents()
                events = event.events
            } catch HttpErrors.invalidResponse {
                 print("Invalid response")
            } catch HttpErrors.parseError {
                print("Parse error")
            } catch {
                print("Unknow error")
            }
        }
    }
    
    struct EventRow: View {
        let event: Event
        var body: some View {
            
            VStack(alignment: .leading) {
                NavigationLink(destination: UserEventDetailView(eventId: event.id)) {
                    Text(event.title)
                        .font(.system(size: 15, weight: .medium))
                    
                    HStack{
                        Text(event.location)
                        Text(event.date)
                    }
                }
            }
        }
    }
    
    func getEvents() async throws -> EventResponse {
        let request = HttpResources.prepareGetRequest(s_url: HttpResources.url_list_events + "?limit=100", token: GlobalStatus.token)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HttpErrors.invalidResponse
        }

        do {
             return try JSONDecoder().decode(EventResponse.self, from: data)
        } catch let error {
            print(error)
            throw HttpErrors.parseError
        }
    }
}

#Preview {
    HomeScreenView()
}
