//
//  HomeScreenView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/10/23.
//

import SwiftUI

//NOT for admin use
//view future events? link to google calendar
//check into current event
//settings/view profile
struct MenuItem: Identifiable {
    var id = UUID()
    var text = String()
    let handler: () -> Void = {
        print("tapped item")
    }
}

struct MenuContent: View {
    let items: [MenuItem] = [
        MenuItem(text: "Home"),
        MenuItem(text: "Settings"),
        MenuItem(text: "Profile"),
        MenuItem(text: "Log Out")

    ]
    var body: some View {
        ZStack{
            Color(Color.white)
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    HStack{
                        Text(item.text)
                            .bold()
                            .foregroundColor(Color.customPurple)
                            .font(.system(size: 22))
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                    }
                    .padding()
                    
                }
                Spacer()
            }
            .padding(.top, 50)
        }
        
    }
    
}


struct SideMenu: View {
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    var body: some View {
        ZStack{
            GeometryReader{ _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture{
                self.toggleMenu()
            }
        }
        
        HStack {
            MenuContent()
                .frame(width: width)
                .offset(x: menuOpened ? 0 : -width)
                .animation(.default)
            Spacer()
        }
        
    }
    
}



struct HomeScreenView: View {
    
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    @State var menuOpened = false;

    var body: some View {
        ZStack{
            Color.customPurple
            if !menuOpened {
                Button(action : {
                    //openMenu
                    self.menuOpened.toggle()
                }, label: {
                    Image("Settings")
//                    Text("Open Menu")
//                        .foregroundColor(Color.customPurple)
//                        .frame(width: 50, height: 50)
//                        .background(Color(Color.white))
                        .resizable()
                        .frame(width: 70, height: 70)
                        .position(x: 50, y: 90)
                })
                
            }
            
            
            VStack{
                //change this to align with current event
                Text("No Current Events")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 50, design: .rounded)
                        .weight(.heavy))
                    .foregroundColor(Color.white)
                    .position(x: width/2, y: height/3)
                
                Button("Check In") {
                    //take to event screen
                }
                .font(.system(size: 40, design: .rounded)
                    .weight(.bold))
                .foregroundColor(Color.customPurple)
                .frame(width: 250, height: 250)
                .background(Color.white)
                .cornerRadius(10)
                .position(x: width/2, y: height/7)
                
                HStack{
                    Button("Calendar") {
                        //take to calendar
                    }
                    .font(.system(size: 20, design: .rounded)
                        .weight(.bold))
                    .foregroundColor(Color.customPurple)
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Button("Directory") {
                        //take to directory
                    }
                    .font(.system(size: 20, design: .rounded)
                        .weight(.bold))
                    .foregroundColor(Color.customPurple)
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(0.4)

                    
                    Button("Extra idk") {
                        //take to somewhere
                    }
                    .font(.system(size: 20, design: .rounded)
                        .weight(.bold))
                    .foregroundColor(Color.customPurple)
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    
                } .padding()

            }

            SideMenu(width: width/1.6, menuOpened: menuOpened, toggleMenu: toggleMenu)

        } .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    
    func toggleMenu() {
        menuOpened.toggle()
    }
}

#Preview {
    HomeScreenView()
}
