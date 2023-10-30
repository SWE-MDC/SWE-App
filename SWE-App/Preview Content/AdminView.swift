//
//  AdminView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/30/23.
//

import SwiftUI

struct AdminView: View {
    @State private var eventName = ""
    @State private var eventDate = ""

    
    
    var body: some View {
        NavigationView{
            VStack() {
                Text("ADMIN VIEW")
                
                TextField("Event Name", text: $eventName)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                TextField("Event Date", text: $eventDate)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                Button("Create New Event"){
                    //creates a new event in database
                    //need to update event name in homescreenview
                }
            }
        }
    }
}

#Preview {
    AdminView()
}
