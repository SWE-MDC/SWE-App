//
//  ReportsView.swift
//  SWE-App
//
//  Created by Liang Geng on 11/16/23.
//

import SwiftUI


struct ReportsView: View {
    @State var eventId: Int = 0
    @State var attendees: [Attendee] = []
    @State var notDecided: String = ""
    @State var accept: String = ""
    @State var reject: String = ""
    @State var showUp: String = ""
    var body: some View {

        VStack {
            List(attendees) {e in

                
                AttendeeRow(attendee: e)
            }
            .navigationTitle("Attendees")
            
            Form {
                HStack{
                    Text("Not decided")
                    Spacer()
                    Text(notDecided)
                }
                HStack{
                    Text("Accept")
                    Spacer()
                    Text(accept)
                }
                HStack{
                    Text("Reject")
                    Spacer()
                    Text(reject)
                }
                HStack{
                    Text("Show up")
                    Spacer()
                    Text(showUp)
                }
            }.navigationTitle("Statistics")
        }
        .task{
             do {
                 let resp = try await getAttendees()
                 attendees = resp.attendees
                 notDecided = String(resp.notDecided)
                 accept = String(resp.accept)
                 reject = String(resp.reject)
                 showUp = String(resp.showUp)
             } catch HttpErrors.invalidResponse {
                  print("Invalid response")
             } catch HttpErrors.parseError {
                 print("Parse error")
             } catch {
                 print("Unknow error")
             }
        }
     }

    

    
    struct AttendeeRow: View {
        let attendee: Attendee

        var body: some View {
            
            VStack(alignment: .leading) {
                let fn = attendee.firstName ?? ""
                let ln = attendee.lastName ?? ""
    
            
  
                    HStack{
                        Text("Name")
                        Spacer()
                        Text(fn + ln)
                    }
                    HStack{
                         Text("Email")
                         Spacer()
                         Text(attendee.email)
                    }
                    HStack{
                         Text("Plan")
                         Spacer()
                        Text(Plan(rawValue: attendee.status)?.text ?? "")
                    }
                    HStack{
                         Text("Comments")
                         Spacer()
                        Text(attendee.comments ?? "")
                    }
                    
        
     
//                    Text(event.title)
//                        .font(.system(size: 15, weight: .medium))
//                    
//                    HStack{
//                        Text(event.location)
//                        Text(event.date)
//                    }
                
            }
        }
    }
                             
     func getAttendees() async throws -> AttendeesResponse {
         let request = HttpResources.prepareGetRequest(s_url: HttpResources.url_get_attendees + "/\(eventId)", token: GlobalStatus.token)
         let (data, response) = try await URLSession.shared.data(for: request)
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             throw HttpErrors.invalidResponse
         }

         do {
              return try JSONDecoder().decode(AttendeesResponse.self, from: data)
         } catch let error {
             print(error)
             throw HttpErrors.parseError
         }
     }
}

#Preview {
    ReportsView()
}
