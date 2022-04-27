//
//  GameListRowView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import SwiftUI

struct GameListRowView: View {
    let userRepo = UserRepository.instance
    var game: Game
    let dateFormatter = DateFormatter()
    
    @ObservedObject var imageRepo = ImageRepository.instance
    
    init(game: Game) {
        self.game = game
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 4) {
                if getOwnerAvatar(of: game) != nil && imageRepo.imageDict[getOwnerAvatar(of: game)!] != nil {
                    Image(uiImage: imageRepo.imageDict[getOwnerAvatar(of: game)!]!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .padding(.horizontal)
                } else {
                    Image("DefaultAvatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .padding(.horizontal)
                }
                
                Text(getOwnername(of: game))
                    .font(.system(size: 14))
            }
            
            VStack {
                Spacer()
                Text(dateFormatter.string(from: game.date))
                Spacer()
                if let oppo = getOpponame(of: game) {
                    Text("VS. \(oppo)")
                } else {
                    Text("Look for opponent")
                }
                Spacer()
            }
            Spacer()
        }
        .frame(height: 70)
    }
}

//struct GameListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: "userid")
//        return GameListRowView(game: game).previewLayout(.fixed(width: 300, height: 70))
//    }
//}
