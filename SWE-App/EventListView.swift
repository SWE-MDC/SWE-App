//
//  EventListView.swift
//  SWE-App
//
//  Created by Liang Geng on 10/30/23.
//
import SwiftUI
import Foundation


struct EventListView: View {
    @Binding var events: [Event]
    var body: some View {
        List(events) { e in
            EventRow(event: e)
        }
    }
}

#Preview {
    EventListView(events: .constant([Event].init()))
}

struct EventRow: View {
    
    let event: Event
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.system(size: 21, weight: .medium))
            
            HStack{
                Text(event.location)
                Text(event.date)
            }
        }
    }
}
