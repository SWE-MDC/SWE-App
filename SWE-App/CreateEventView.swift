//
//  AdminNewEvent.swift
//  SWE-App
//
//  Created by Alex on 10/31/23.
//

import Foundation
import SwiftUI

struct CreateEventView: View {
    @State private var eventName = ""
//    @State private var eventDate = ""
    @State private var eventDetails = ""
    @State private var eventLocation = ""
    @State var currentTime = Date()
    @State private var addEventFailed = false;
    @State private var eventAdded = false;
    @State private var errorMsg = ""
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State private var width = UIScreen.main.bounds.width


    var closedRange = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack() {
                    Section{
                        Text("New Event")
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .bold()
                        ScrollView{
                            TextField("Event Name/Title", text: $eventName)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                            
                            // https://www.youtube.com/watch?v=9UovPNh4Csw
                            Section(){
                                DatePicker("Date & Time: ", selection: $currentTime, in: Date()...)
                                //DatePicker("Date & Time: ", selection: $currentTime, in: Date()...).labelsHidden() use this if you don't want the label to show.
                            }
                            .padding()
                            .frame(width: 300, height: 80)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            
                            TextField("Event Location", text: $eventLocation)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                            
                            TextField("Event Details", text: $eventDetails, axis: .vertical)
                                .padding()
                                .frame(width: 300, height: 200)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                            
                            Button("Create New Event"){
                                //creates a new event in database
                                //need to update event name in homescreenview
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "y-M-d hh:mm"
                                let s_date = dateFormatter.string(from: currentTime)
                                errorMsg = ""
                                addEventFailed = false
                                eventAdded = false
                                createEvent(title: eventName, details: eventDetails, date: s_date, location: eventLocation)
                                eventAdded = !addEventFailed
                                
                            }.alert(errorMsg, isPresented: $addEventFailed)
                            {
                                Button("OK", role: .cancel) { }
                            }
                            
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.customPurple)
                            .cornerRadius(10)
                            
                            NavigationLink(destination: HomeScreenView(), isActive: $eventAdded) { Text("Back to Home Screen")}
                                .frame(width: 300, height: 50)
                            
                            //                Section(header:Text("Result")){ //you can remove this
                            //                    Text("\(currentTime)")
                            //                }
                        }//end scroll view
                        .frame(height: 600)
                        .position(x: width/2, y:130)
                        
                    } //end section
                    .position(x: width/2, y: 140)
                    
                } //end VStack
                
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
    
    
    func createEvent(title: String, details: String, date: String, location: String) {
        let semaphore = DispatchSemaphore(value: 0)
        // prepare json data
        let json: [String: Any] = ["title": title,
                                   "details": details,
                                   "date": date,
                                   "location":location]
        let request = HttpResources.preparePostRequest(s_url: HttpResources.url_add_event, json: json, token: GlobalStatus.token)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                errorMsg = error?.localizedDescription ?? "No data"
                semaphore.signal()
                return
            }
            
            do {
                 let resp = try JSONDecoder().decode(GenericResponse.self, from: data)
                
                if resp.status == 200 {
                    errorMsg = ""
                } else {
                    errorMsg = resp.message
                }
            } catch let error {
                errorMsg = "Parse error"
                print(error)
            }

            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        addEventFailed = (errorMsg != "")
 
    }
}

#Preview {
    CreateEventView()
}
