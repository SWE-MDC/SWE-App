//
//  DirectoryView.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/30/23.
//

import SwiftUI

struct DirectoryView: View {
    
    //not suitable for rotation or scaling
    @State private var width = UIScreen.main.bounds.width
    @State private var height = UIScreen.main.bounds.height
    
    @State private var code = ""
    

    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.customPurple)
                    .frame(width: width, height: 220, alignment: .top)
                    .ignoresSafeArea()
                    .position(x: width/2, y: 0)
                
                VStack {
                    Text("Directory")
                        .font(.system(size: 50, design: .rounded)
                            .weight(.heavy))
                        .foregroundColor(Color.white)
                        .position(x: width/2, y: 50)
                }
                
                
              
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    DirectoryView()
}
