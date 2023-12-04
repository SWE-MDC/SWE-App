//
//  HomeScreenView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/10/23.
// This is a simple comment.
//

import SwiftUI
import UIKit

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
                    Text("Latest Events")
                        .font(.largeTitle)
                        .bold()
                        .position(x: width/2, y: 120)
                        .foregroundColor(.white)
                    
                    //list of all events in database in order by date
                    List(events) {e in
                        EventRow(event: e)
                        .foregroundColor(.black)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 5)
                                .background(.clear)
                                .foregroundColor(.white)
                                .padding(
                                    EdgeInsets(
                                        top: 2,
                                        leading: 10,
                                        bottom: 2,
                                        trailing: 10
                                                )
                                        )
                                )
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                    .frame(width: 400, height: 570)
                    .position(x: width/2, y: 60)
                    
                    
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
                //orders events by date
                events.sort {
                    $0.date < $1.date
                }
                
            } catch HttpErrors.invalidResponse {
                 print("Invalid response")
            } catch HttpErrors.parseError {
                print("Parse error")
            } catch {
                print("Unknown error")
            }
        }
    }
    
    //layout for each individual event
    struct EventRow: View {
        let event: Event
        var body: some View {
            VStack(alignment: .leading) {
                NavigationLink(destination: UserEventDetailView(eventId: event.id)) {
                    
                    VStack(alignment: .leading){
                        Text(event.title)
                            .font(.system(size: 21, weight: .medium))
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
