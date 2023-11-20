//
//  ProfileEditView.swift
//  SWE-App
//
//  Created by Becca Pratel on 11/5/23.
//

import SwiftUI

struct ProfileEditView: View {
    
    /* Note: currently not allowing changing email
     because it would mess up registration/account creation */
    @State private var name = ""
    @State private var selectedPronouns = ""
    @State private var selectedMajor = ""
    @State private var selectedYear = ""
    
    // These handle information about affinity group memberships
    @State private var memberOfGroup1 = false;
    @State private var memberOfGroup2 = false;
    @State private var memberOfGroup3 = false;
    @State private var memberOfGroup4 = false;
    @State private var memberOfGroup5 = false;
    @State private var memberOfGroup6 = false;
    @State private var memberOfGroup7 = false;
    @State private var memberOfGroup8 = false;
    
    // Names of all affinity groups
    @State private var group1Name = "African-American Affinity Group"
    @State private var group2Name = "Asian Connections Affinity Group"
    @State private var group3Name = "HeForSWE Affinity Group"
    @State private var group4Name = "Latinx Affinity Group"
    @State private var group5Name = "LGBTQ+ Affinity Group"
    @State private var group6Name = "Native American/Indigenous Peoples Affinity Group"
    @State private var group7Name = "Military & Veterans Affinity Group"
    @State private var group8Name = "DisAbilityInclusion Affinity Group"
    
    let pronounOptions = ["she/her", "he/him", "they/them", "she/they", "he/they", "Prefer not to answer"]
    
    // Alphabetical list of all options for majors in the College of Engineering
    let majorOptions = ["Aerospace Engineering", "Architecture", "Aviation", "Biomedical Engineering", "Chemical Engineering", "City and Regional Planning", "Civil Engineering", "Computer Science and Engineering", "Electrical and Computer Engineering", "Engineering Physics", "Engineering Technology", "Environmental Engineering", "Food, Agricultural and Biological Engineering", "Industrial and Systems Engineering", "Landscape Architecture", "Materials Science and Engineering", "Mechanical Engineering", "Welding Engineering"]
    
    // Currently lists only Freshman to Senior, need to ask how they want 5th year and above to be represented
    let yearOptions = ["Freshman", "Sophomore", "Junior", "Senior"]
    
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    NavigationView {
                        Form {
                            Text("Edit Profile")
                                .font(.largeTitle)
                                .bold()
                                .multilineTextAlignment(.center)
                            // handles name updaytes
                            Section("Update name") {
                                TextField("Name:", text: $name)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                                    .textInputAutocapitalization(.never)
                            }
                            // handles pronoun updates
                            Section("Update Pronouns") {
                                Picker("Pronouns", selection: $selectedPronouns) {
                                    ForEach(pronounOptions, id: \.self) {
                                        Text($0)
                                    }
                                    .pickerStyle(.menu)
                                }
                            }
                            // handles major updates
                            Section("Update Major"){
                                Picker("Major", selection: $selectedMajor) {
                                    ForEach(majorOptions, id: \.self) {
                                        Text($0)
                                    }
                                    .pickerStyle(.menu)
                                }
                            }
                            // handles year updates
                            Section("Update Year"){
                                Picker("Year in school", selection: $selectedYear) {
                                    ForEach(yearOptions, id: \.self) {
                                        Text($0)
                                    }
                                    .pickerStyle(.menu)
                                }
                            }
                            // handles affinity group membership updates
                            Section("Update Affinity Group Memberships"){
                                
                                Toggle(isOn: $memberOfGroup1) {
                                    Text(group1Name)
                                }
                                Toggle(isOn: $memberOfGroup2) {
                                    Text(group2Name)
                                }
                                Toggle(isOn: $memberOfGroup3) {
                                    Text(group3Name)
                                }
                                Toggle(isOn: $memberOfGroup4) {
                                    Text(group4Name)
                                }
                                Toggle(isOn: $memberOfGroup5) {
                                    Text(group5Name)
                                }
                                Toggle(isOn: $memberOfGroup6) {
                                    Text(group6Name)
                                }
                                Toggle(isOn: $memberOfGroup7) {
                                    Text(group7Name)
                                }
                                Toggle(isOn: $memberOfGroup8) {
                                    Text(group8Name)
                                }
                            }
                            // allows useer to submit updated profile
                            Button("Submit"){
                                //updates profile info in the database
                            }.foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(Color.customPurple)
                                .cornerRadius(10)
                        } //end Form
                        
                    } //end NavigationView
                    /* Allows naviagtion back to profile screen with or without submitting new profile info */
                    NavigationLink(destination: ProfileView(profile: allProfiles[0])) { Text("Back to Profile Screen")}
                        .frame(width: 300, height: 50)
                } //end VStack
                //used to display side bar menu
                //put inside zstack
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        sideMenu()
                        //hides the side menu with showMenu is false
                        .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                        .animation(.easeInOut(duration: 0.3), value: showMenu)
                    }
                }
                //when side menu is open, it darkens the rest of the screen
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            }//end ZStack
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//            .navigationTitle("Menu:")
//            .navigationBarTitleDisplayMode(.inline) //lines title up with icon


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
        }.navigationBarHidden(true)
    }
}

#Preview {
    ProfileEditView()
    //ProfileEditView(profile: allProfiles[0])
}
