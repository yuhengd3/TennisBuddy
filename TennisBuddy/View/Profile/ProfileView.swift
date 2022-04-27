//
//  ProfileView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/27.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    
    @ObservedObject var userViewModel = globalUserViewModel
    
    @State private var toggleOn = true
    @State private var showImagePicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("PrincetonOrange"))
                    .ignoresSafeArea()
                    .frame(height: 80)
                    
                Text("Profile")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            if let user = userViewModel.currUser {
                NavigationView {
                    VStack {
                        VStack {
                            Spacer()
                                .frame(height: 14)
                            
                            Button {
                                showImagePicker.toggle()
                            } label: {
                                if userViewModel.avatarReady {
                                    Image(uiImage: userViewModel.avatar)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                        .padding(.horizontal, 15)
                                } else {
                                    Image("DefaultAvatar")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                        .padding(.horizontal, 15)
                                }
                            }
                            .popover(isPresented: $showImagePicker) {
                                ImagePicker(selectedImage: $userViewModel.avatar, didSet: $userViewModel.avatarReady)
                            }
                            
                            
                            Spacer()
                                .frame(height: 14)
                            
                            Text("\(user.username)")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            
                            if let desc = user.description {
                                Spacer()
                                    .frame(height: 10)
                                Text("\(desc)")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 60)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            Divider()
                                .frame(height: 3)
                                .background(Color("ListBackground"))
                                .padding(.horizontal, 36)
                            
                            Spacer()
                                .frame(height: 16)
                            
                            HStack {
                                VStack(spacing:3) {
                                    Text("\(Int(user.rating ?? 0))")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                    
                                    Text("Rating")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 40)
                                
                                VStack(spacing:3) {
                                    Text("\(user.numGames)")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                    
                                    Text("Games")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 40)
                            }
                            
                            Spacer()
                                .frame(height: 12)
                            
                        }
                        .background(Color("LightGray"))
                    
                        ZStack {
                            VStack {
                                HStack {
                                    Spacer()
                                }
                                Spacer(minLength: 0)
                            }
                            .background(Color("LightGray"))
                            
                            Rectangle()
                            .cornerRadius(24)
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                            
                            
                            VStack {
                                Spacer()
                                    .frame(height: 24)
                                
                                
                                NavigationLink{
                                    Text("Edit Profile")
                                } label: {
                                    HStack {
                                        Spacer()
                                            .frame(width: 40)
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 48, height: 48)
                                                .cornerRadius(10)
                                                .foregroundColor(Color("ListBackground"))
                                            Image(systemName: "pencil.circle.fill")
                                                .font(.system(size: 24))
                                                .padding(10)
                                        }
                                        Spacer()
                                            .frame(width: 20)
                                        
                                        Text("Edit Profile")
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                }
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                                .foregroundColor(.black)
                                
                                
                                HStack {
                                    
                                    Spacer()
                                        .frame(width: 40)
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 48, height: 48)
                                            .cornerRadius(10)
                                            .foregroundColor(Color("ListBackground"))
                                        Image(systemName: "bell.circle.fill")
                                            .font(.system(size: 24))
                                            .padding(10)
                                    }
                                    
                                    Spacer()
                                        .frame(width: 20)
                                    
                                    Text("Notification")
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $toggleOn)
                                    
                                    Spacer()
                                        .frame(width: 40)
                                }
                                
                                NavigationLink{
                                    Text("Information")
                                } label: {
                                    
                                    HStack {
                                        
                                        Spacer()
                                            .frame(width: 40)
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 48, height: 48)
                                                .cornerRadius(10)
                                                .foregroundColor(Color("ListBackground"))
                                            Image(systemName: "info.circle.fill")
                                                .font(.system(size: 24))
                                                .padding(10)
                                        }
                                            
                                        Spacer()
                                            .frame(width: 20)
                                        
                                        Text("Information")
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                }
                                .foregroundColor(.black)
                                
                                Button {
                                    userViewModel.currUser = nil
                                    userViewModel.avatarReady = false
                                } label: {
                                    HStack {
                                        
                                        Spacer()
                                            .frame(width: 40)
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 48, height: 48)
                                                .cornerRadius(10)
                                                .foregroundColor(Color("ListBackground"))
                                            Image(systemName: "arrow.right.circle.fill")
                                                .font(.system(size: 24))
                                                .padding(10)
                                        }
                                        
                                        Spacer()
                                            .frame(width: 20)
                                        
                                        Text("Log Out")
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                }
                                .foregroundColor(.black)
                                
                                
                                
                                
                                Spacer()
                            }
                        }
                    }
                }
                .onAppear {
                    UserRepository.instance.db.collection("users")
                        .document(userViewModel.currUser!.documentId!).getDocument {(document, error) in
                            if let document = document {
                                let username: String = document.data()!["username"] as! String
                                let uid: String = document.data()!["uid"] as! String
                                let avatar: String? = document.data()?["avatar"] as? String
                                let rating: Double? = document.data()?["rating"] as? Double
                                let numGames = document.data()?["numGames"] as? Int ?? 0
                                let description: String? = document.data()?["description"] as? String
                                let user = User(username: username, uid: uid, avatar: avatar, rating: rating, numGames: numGames, description: description, documentId: document.documentID)
                                userViewModel.currUser = user
                            }
                    }
                }
                
            } else {
                AuthView()
            }
            
            
            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
