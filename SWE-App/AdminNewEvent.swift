//
//  AdminNewEvent.swift
//  SWE-App
//
//  Created by Alex on 10/31/23.
//

import Foundation
import SwiftUI

struct AdminNewEvent: View {
    @State private var eventName = ""
//    @State private var eventDate = ""
    @State private var eventDetails = ""
    @State private var eventLocation = ""
    @State private var date = Date()
    @State var currentTime = Date()


    var closedRange = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    
    var body: some View {
        NavigationView{
            VStack() {
                Text("New Event")
                    .padding()
                
                TextField("Event Name/Title", text: $eventName)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
//                TextField("Event Date", text: $eventDate)
//                    .padding()
//                    .frame(width: 300, height: 50)
//                    .background(Color.black.opacity(0.05))
//                    .cornerRadius(10)
//                    .textInputAutocapitalization(.never)
                
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
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.customPurple)
                .cornerRadius(10)
                
                NavigationLink(destination: AdminView()) { Text("Back to Admin Screen")}
                    .frame(width: 300, height: 50)
                
//                Section(header:Text("Result")){ //you can remove this
//                    Text("\(currentTime)")
//                }
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    AdminNewEvent()
}
