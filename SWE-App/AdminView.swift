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


    var closedRange = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    
    var body: some View {
        NavigationView{
//            ZStack{
//                Text("Admin View")
//
//            }
//            .frame(width: 200, height: 50)
//            .padding()
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
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    AdminView()
}
