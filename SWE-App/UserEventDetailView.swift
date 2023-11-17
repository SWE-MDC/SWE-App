//
//  UserEventDetailView.swift
//  SWE-App
//
//  Created by Liang Geng on 11/16/23.
//

import SwiftUI

enum Plan: Int, CaseIterable, Identifiable {
    case NOT_DECIDED = 0, ACCEPT = 1, REJECT = 2
    var id: Self {self}
    var text: String {
        switch self {
        case .NOT_DECIDED: return "Not Decided"
        case .ACCEPT: return "Accept"
        case .REJECT: return "Reject"
        }
    }
}

struct UserEventDetailView: View {
    var eventId: Int = 0
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    @State private var selectedPlan: Plan = .NOT_DECIDED
    @State private var comments: String = ""
    @State private var submitted: Bool = false
    @State var details: EventDetails = EventDetails()
    @State private var checkedin: Bool = false
    @State var checkinCode: String = ""
    @State var checkinError: Bool = false
    @State var checkinErrorMsg: String = ""
    
    var body: some View {
        ZStack {
            
            Text(details.title)
                .font(.title)
                .fontWeight(.medium)
            
            VStack{
                Form {
                    HStack{
                        Text("Date")
                        Spacer()
                        Text(details.date)
                    }
                    HStack{
                        Text("Location")
                        Spacer()
                        Text(details.location)
                    }
                    HStack{
                        Text("Details")
                        Spacer()
                        Text(details.details)
                    }
                    HStack{
                        Text("Organizer")
                        Spacer()
                        Text(details.organizer)
                    }
                    
                    Picker("Plan", selection: $selectedPlan) {
                        Text("Not decided").tag(Plan.NOT_DECIDED)
                        Text("Accept").tag(Plan.ACCEPT)
                        Text("Reject").tag(Plan.REJECT)
                    }.disabled(submitted || details.status != Plan.NOT_DECIDED.rawValue)
                    
                    HStack {
                        TextField("Comments", text: $comments)
                            .disabled(submitted)
                    }
                    HStack{
                        Text("Checkin Code")
                        Spacer()
                        TextField("Type in here", text: $checkinCode)
                            .disabled(details.showUp == 1 ||
                                      details.status == Plan.REJECT.rawValue || checkedin)
                    }
                }
                
                
                
                NavigationLink(destination: ReportsView(eventId: eventId)) 
                {
                    Text("Check Attendees").padding(15)
                }.disabled(!GlobalStatus.isAdmin)
                
                
                HStack {
                    Button("Submit Plan") {
                        updateEventStatus()
                    }.disabled(submitted)
                    Spacer()
                    
                    Button("Checkin Event") {
                        checkinError = false
                        checkinErrorMsg = ""
                        checkin()
                    }
                    .disabled(details.showUp == 1 ||
                              details.status == Plan.REJECT.rawValue || checkedin)
                    .alert(checkinErrorMsg, isPresented: $checkinError)
                    {
                        Button("OK", role: .cancel) { }
                    }
                    
                }.padding()
            }

            
            GeometryReader { _ in
                HStack {
                    Spacer()
                    sideMenu()
                    //hides the side menu with showMenu is false
                    .offset(x: showMenu ? 0 : width)
                    .animation(.easeInOut(duration: 0.3), value: showMenu)
                }
            }
            //when side menu is open, it darkens the rest of the screen
            .background(Color.black.opacity(showMenu ? 0.5 : 0))
        }
        .task {
                do {
                    let resp = try await getEventDetails()
                    details = resp.eventDetails
                    selectedPlan = Plan(rawValue: details.status)!
                    comments = resp.eventDetails.comments
                    submitted = details.status != Plan.NOT_DECIDED.rawValue
                    if (GlobalStatus.isAdmin) {
                        checkinCode = details.eventCode
                    }
                } catch HttpErrors.invalidResponse {
                     print("Invalid response")
                } catch HttpErrors.parseError {
                    print("Parse error")
                } catch {
                    print("Unknow error")
                }
        }
        
        
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
    
    func getEventDetails() async throws -> EventDetailsResponse {
        let request = HttpResources.prepareGetRequest(s_url: HttpResources.url_get_event_details + "/\(eventId)", token: GlobalStatus.token)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HttpErrors.invalidResponse
        }

        do {
             return try JSONDecoder().decode(EventDetailsResponse.self, from: data)
        } catch let error {
            print(error)
            throw HttpErrors.parseError
        }
    }
    
    func updateEventStatus() {
        let semaphore = DispatchSemaphore(value: 0)
        // prepare json data
        let json: [String: Any] = ["eventId": eventId,
                                   "status": selectedPlan.rawValue,
                                   "comments": comments]
        let request = HttpResources.preparePostRequest(s_url: HttpResources.url_update_event_details, json: json, token: GlobalStatus.token)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        semaphore.signal()
                        return
                    }
                    
                    do {
                         let resp = try JSONDecoder().decode(GenericResponse.self, from: data)
                        if resp.status == 200 {
                            submitted = true
                        }
                        print(resp)
                    } catch let error {
                        print(error)
                    }

                    semaphore.signal()
                }
        task.resume()
        semaphore.wait()
    }
    
    func checkin() {
        let semaphore = DispatchSemaphore(value: 0)
        // prepare json data
        let json: [String: Any] = ["eventId": eventId,
                                   "checkinCode": checkinCode,
                                   ]
        let request = HttpResources.preparePostRequest(s_url: HttpResources.url_checkin_event, json: json, token: GlobalStatus.token)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        semaphore.signal()
                        return
                    }
                    
                    do {
                         let resp = try JSONDecoder().decode(GenericResponse.self, from: data)
                        if resp.status == 200 {
                            checkedin = true
                        } else {
                            checkinError = true
                            checkinErrorMsg = resp.message
                        }
                        print(resp)
                    } catch let error {
                        print(error)
                    }

                    semaphore.signal()
                }
        task.resume()
        semaphore.wait()
    }
}

#Preview {
    UserEventDetailView()
}
