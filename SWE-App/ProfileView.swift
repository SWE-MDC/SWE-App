//
//  ProfileView.swift
//  SWE-App
//
//  Created by Becca Pratel on 11/5/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var showMenu: Bool = false
    @State var menuOpened = false;
    @State private var width = UIScreen.main.bounds.width
    @State var profile: UserProfileResponse = UserProfileResponse()
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack() {
                    Image("Logo")
                        .resizable()
//                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height:150)
//                        .clipped()
                        .cornerRadius(150)
                        .shadow(radius: 3)
                        .padding([.top], 80)
                    
                    Form {
                        HStack{
                            Text("First Name")
                            Spacer()
                            Text(profile.firstName ?? "")
                        }
                        HStack{
                            Text("Last Name")
                            Spacer()
                            Text(profile.lastName ?? "")
                        }
                        HStack{
                            Text("Email")
                            Spacer()
                            Text(profile.email)
                        }
                        HStack{
                            Text("Pronouns")
                            Spacer()
                            Text(profile.pronouns ?? "")
                        }
                        HStack{
                            Text("Major")
                            Spacer()
                            Text(profile.major ?? "")
                        }
                        HStack{
                            Text("Year")
                            Spacer()
                            Text(profile.year ?? "")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.customPurple)
                    NavigationLink(destination: ProfileEditView(firstName: profile.firstName ?? "",
                                                                lastName: profile.lastName ?? "",
                                                                selectedPronouns: profile.pronouns ?? "",
                                                                selectedMajor: profile.major ?? "",
                                                                selectedYear: profile.year ?? "")) { Text("Edit Profile Information")}
                        .frame(width: 300, height: 50)
                        .foregroundColor(.black)
                } //end VStack
                //.background(Color.customPurple)
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
            } //end ZStack
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
            .task {
                do {
                    let resp = try await getUserProfile()
                    profile = resp
                } catch HttpErrors.invalidResponse {
                     print("Invalid response")
                } catch HttpErrors.parseError {
                    print("Parse error")
                } catch {
                    print("Unknow error")
                }
                
            }
    }
    
    func getUserProfile() async throws -> UserProfileResponse {
        let request = HttpResources.prepareGetRequest(s_url: HttpResources.url_user_profile, token: GlobalStatus.token)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HttpErrors.invalidResponse
        }

        do {
             return try JSONDecoder().decode(UserProfileResponse.self, from: data)
        } catch let error {
            print(error)
            throw HttpErrors.parseError
        }
    }
}

#Preview {
    ProfileView()
}
