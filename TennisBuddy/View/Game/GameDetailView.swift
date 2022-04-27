//
//  GameDetailView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/23.
//

import SwiftUI
import FirebaseFirestore

struct GameDetailView: View {
    let dateFormatter = DateFormatter()
    @ObservedObject var vm : GameDetailViewModel
    @ObservedObject var imageRepo = ImageRepository.instance
    
    @State private var enteredPasscode = ""
    @State private var selectedGameStatus = Game.GameStatus.ownerWin
    @State private var showingAlert = false
    
    init(game: Game) {
        vm = GameDetailViewModel(game: game)
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Time: \(dateFormatter.string(from: vm.game.date))")
                    Text("Location: \(vm.game.location)")
                    HStack {
                        Text("Number of Sets: \(vm.game.numSets)")
                            .padding(.trailing)
                        if vm.game.numSets == 3 {
                            Text("(90 min)")
                        } else {
                            Text("(2 h 45 min)")
                        }
                        
                    }
                    Text("Description:")
                    Text(vm.game.description)
                        .padding(.bottom, 50)
                    
                    HStack {
                        Spacer(minLength: 0)
                        VStack(spacing: 6) {
                            if vm.owner.avatar != nil && imageRepo.imageDict[vm.owner.avatar!] != nil {
                                Image(uiImage: imageRepo.imageDict[vm.owner.avatar!]!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 15)
                            } else {
                                Image("DefaultAvatar")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 15)
                            }
                            Text("\(vm.owner.username)")
                            if let rating = vm.owner.rating {
                                Text("Rating: \(Int(rating))")
                            } else {
                                Text("Rating: N/A")
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 200)
                        
                        Spacer(minLength: 0)
                        
                        VStack {
                            Spacer()
                                .frame(height: 12)
                            ZStack {
                                Rectangle()
                                    .fill(.black)
                                    .frame(width: 90, height: 4)
                                    .mask(LinearGradient(gradient: Gradient(colors: [.clear, .black, .black, .clear]), startPoint: .leading, endPoint: .trailing))
                                
                                Circle()
                                    .fill(.black)
                                    .frame(width: 40, height: 40)
                                
                                Text("VS")
                                    .foregroundColor(.white)
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 200)
                        Spacer(minLength: 0)
                        VStack(spacing: 6) {
                            if let oppo = vm.opponent {
                                if oppo.avatar != nil && imageRepo.imageDict[oppo.avatar!] != nil {
                                    Image(uiImage: imageRepo.imageDict[oppo.avatar!]!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .padding(.horizontal, 15)
                                } else {
                                    Image("DefaultAvatar")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .padding(.horizontal, 15)
                                }
                                Text("\(oppo.username)")
                                if let rating = oppo.rating {
                                    Text("Rating: \(Int(rating))")
                                } else {
                                    Text("Rating: N/A")
                                }
                            } else {
                                Image("QuestionMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 25)
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 200)
                        Spacer(minLength: 0)
                    }
                    
                    Spacer(minLength: 0)
                    
                    
                }
                .padding(26)
                
                if vm.showJoinButton {
                    Button {
                        vm.joinGame()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Join Game")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .font(Font.headline.smallCaps())
                        .background(Color("PrincetonOrange"))
                    }
                } else if vm.showPasscode {
                    HStack {
                        Spacer()
                        Text("Passcode: \(vm.passcode)")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .font(Font.headline.smallCaps())
                    .background(Color("PrincetonOrange"))
                } else if vm.showSubmitResult {
                    VStack {
                        TextField("Passcode: ", text: $enteredPasscode)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.characters)
                            .padding()
                        
                        Text("Who won?")
                        
                        Picker("Who won?", selection: $selectedGameStatus) {
                            Text(vm.owner.username).tag(Game.GameStatus.ownerWin)
                            Text(vm.opponent!.username).tag(Game.GameStatus.oppoWin)
                        }
                        
                        Button {
                            // vm.submit result
                            if enteredPasscode != vm.passcode {
                                showingAlert = true
                            } else {
                                vm.updateGameStatus(selectedGameStatus)
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Submit Result")
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .font(Font.headline.smallCaps())
                            .background(Color("PrincetonOrange"))
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Passcode incorrect"), dismissButton: .default(Text("Okay")))
                        }
                    }
                    
                } else if vm.showStatus {
                    HStack {
                        Spacer()
                        Text("\(vm.getStatusString())")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .font(Font.headline)
                    .background(Color("PrincetonOrange"))
                }
                
            }
            //.padding()
            
            Spacer(minLength: 0)
        }
        .navigationTitle("Game Detail")
        .onAppear {
            vm.update()
        }
        .onDisappear {
            vm.gameRepo.refresh()
        }
    }
}

//struct GameDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        // let user = User(username: "yuheng", uid: "134A8B23", avatar: nil)
//        // let user2 = User(username: "yuheng", uid: "134A8B23", avatar: nil, rating: 300)
//        let game = Game(date: Date.now, location: "WashU", description: disc, owner: "user", opponent: "user2")
//        GameDetailView(game: game)
//    }
//}
