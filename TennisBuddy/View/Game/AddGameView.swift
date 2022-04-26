//
//  AddGameView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/10.
//

import SwiftUI

struct AddGameView: View {
    @Binding var showSheet: Bool
    @State var showCancel = false
    
    @State private var location: String = ""
    @State private var date = Date()
    @State private var numSets = 3
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        showCancel = true
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.system(size: 22))
                            .padding()
                    })
                        .confirmationDialog("", isPresented: $showCancel, titleVisibility: .hidden) {
                            Button("Discard Game") {
                                showSheet = false
                            }
                        }
                    Text("New Game")
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        showSheet = false
                        
                        // TODO: Connect to Firebase
                    }, label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color("PrincetonOrange"))
                            .font(.system(size: 22))
                        .padding()
                    })
                }
                
                Divider()
                
                List {
                    Section() {
                        HStack {
                            Image(systemName: "location")
                                .foregroundColor(.gray)
                                .font(.system(size: 22))
                                .padding(.maximum(4, 4))
                            TextField("Location", text: $location)
                                .font(.system(size: 20))
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                        }
                    }
                    
                    Section() {
                        VStack(spacing: 8) {
                            HStack {
                                Image(systemName: "clock.arrow.circlepath")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 22))
                                    .padding(.maximum(4, 4))
                                Text("Date")
                                    .font(.system(size: 20))
                                Spacer()
                            }
                            Divider()
                            DatePicker(selection: $date, in: Date()..., label: {
                                Text("Time:")
                            })
                        }
                    }
                    
                    Section {
                        HStack {
                            Image(systemName: "person.3")
                                .foregroundColor(.gray)
                                .font(.system(size: 22))
                                .padding(.maximum(4, 4))
                            Picker("Number of Sets", selection: $numSets) {
                                Text("3").tag(3)
                                Text("5").tag(5)
                            }
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                        }
                    }
                    
                    Section {
                        VStack(spacing: 8) {
                            HStack {
                                Image(systemName: "text.justify")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 22))
                                    .padding(.maximum(4, 4))
                                Text("Description")
                                    .font(.system(size: 20))
                                Spacer()
                            }
                            
                            Divider()
                            
                            TextEditor(text: $description)
                                .font(.system(size: 20))
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct AddGameView_Previews: PreviewProvider {
    @State static var flag = false
    static var previews: some View {
        AddGameView(showSheet: $flag)
    }
}
