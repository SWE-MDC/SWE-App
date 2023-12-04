//
//  DetailEventView.swift
//  SWE-App
//
//  Created by Sam Weigman on 11/2/23.
//

import SwiftUI

struct DetailDirectoryView: View {
    let contact: Contact
    
    var body: some View {
        //detailed view for each individual contact
        VStack {
            Image(contact.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .shadow(radius: 3)
            
            Text(contact.name)
                .font(.title)
                .fontWeight(.medium)
            
            Form {
                HStack{
                    Text("Email")
                    Spacer()
                    Text(contact.email)
                }
            }
        }
    }
}

#Preview {
    DetailDirectoryView(contact: contacts[0])
}
