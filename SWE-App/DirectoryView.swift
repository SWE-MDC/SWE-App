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
    var body: some View {
        NavigationView {
            List(contacts) { contact in
                NavigationLink(destination: DetailDirectoryView(contact: contact)){
                    ContactRow(contact: contact)
                }
            } .navigationBarTitle("Directory")
        }
        
    }
}

#Preview {
    DirectoryView()
}

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
