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
                            Image("DefaultAvatar")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding(.horizontal, 15)
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
                                Image("DefaultAvatar")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 15)
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
                
                if vm.showJoinButton() {
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
                }
                
            }
            //.padding()
            
            Spacer(minLength: 0)
        }
        .navigationTitle("Game Detail")
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
