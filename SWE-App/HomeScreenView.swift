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
        MenuItem(text: "Profile")
    ]
    var body: some View {
        ZStack{
            Color(Color.customPurple)
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    HStack{
                        Text(item.text)
                            .bold()
                            .foregroundColor(Color.white)
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
            if !menuOpened {
                Button(action : {
                    //openMenu
                    self.menuOpened.toggle()
                }, label: {
                    Text("Open Menu")
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 50)
                        .background(Color(.systemBlue))
                })
               
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
