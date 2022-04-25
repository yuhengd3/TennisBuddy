//
//  ProfileView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/27.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel = globalUserViewModel
    
    @State private var toggleOn = true
    
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
            
            if userViewModel.model.uid == nil {
                VStack {
                    Spacer()
                        .frame(height: 14)
                    
                    Image("DefaultAvatar")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.horizontal, 15)
                    
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
                            Text("345")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                            
                            Text("Rating")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 40)
                        
                        VStack(spacing:3) {
                            Text("34")
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
                        
                        
                        
                        Spacer()
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
