//
//  DetailEventView.swift
//  SWE-App
//
//  Created by Sam Weigman on 11/2/23.
//

import SwiftUI

struct DetailEventView: View {
    let event: Events
    
    var body: some View {
        VStack {
            
            Text(event.name)
                .font(.title)
                .fontWeight(.medium)
            
            Form {
                HStack{
                    Text("Date")
                    Spacer()
                    Text(event.date)
                }
                HStack{
                    Text("Time")
                    Spacer()
                    Text(event.time)
                }
                HStack{
                    Text("Location")
                    Spacer()
                    Text(event.location)
                }
            }
        }
    }
}

#Preview {
    DetailEventView(event: events[0])
}
