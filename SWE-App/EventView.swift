//
//  EventView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/31/23.
//

import SwiftUI

struct EventView: View {
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    
    
    var body: some View {
        NavigationView {
            ZStack {
                List(events){ event in
                    NavigationLink(destination: DetailEventView(event: event)){
                        ExtractedView(events:event)
                    }
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
      
    }
        
}

#Preview {
    EventView()
}

struct ExtractedView: View {
//    let events: Events
//
//    var body: some View {
//        HStack{
//            
//            VStack(alignment: .leading){
//                
////TODO: change to use Event struct from EventResponse and probably delete Event file
//                Text(events.name)
//                    .font(.system(size: 21, weight: .medium))
//                Text(events.date)
//  
//
//            }
//        
//        }
//        
//       
//
//    }
}
