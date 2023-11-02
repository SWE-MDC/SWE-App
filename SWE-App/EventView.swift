//
//  EventView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/31/23.
//

import SwiftUI

struct EventView: View {
    var body: some View {
        List(events){ event in
            ExtractedView(events:event)
        }
      
    }
        
}

#Preview {
    EventView()
}

struct ExtractedView: View {
    let events: Events

    var body: some View {
        HStack{
            
            VStack(alignment: .leading){
                
//TODO: change to use Event struct from EventResponse and probably delete Event file
                Text(events.name)
                    .font(.system(size: 21, weight: .medium))
                Text(events.date)
                Text(events.time)
                Text(events.location)
                
                    
                

            }
        
        }
        
       

    }
}
