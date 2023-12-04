//
//  DirectoryView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/30/23.
//

import SwiftUI
import Foundation

//TODO: add a go back home button

struct DirectoryView: View {
    
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                List(contacts) { contact in
                    NavigationLink(destination: DetailDirectoryView(contact: contact)){
                        ContactRow(contact: contact)
                    }
                } .navigationBarTitle("Directory")
                
                
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
        } //end navigation view
    } //end body
} //end directory view



struct ContactRow: View {
    
    let contact: Contact
    var body: some View {
        
        HStack{
            Image(contact.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(50)
            
            VStack(alignment: .leading){
                Text(contact.name)
                    .font(.system(size: 21, weight: .medium))
                Text(contact.email)
            }
        }
    }
}

#Preview {
    DirectoryView()
}
