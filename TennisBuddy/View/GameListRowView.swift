//
//  GameListRowView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import SwiftUI

struct GameListRowView: View {
    var game: Game
    let dateFormatter = DateFormatter()
    
    init(game: Game) {
        self.game = game
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Image("DefaultAvatar")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.horizontal)
                Text(game.owner)
                    .font(.system(size: 14))
            }
            
            VStack {
                Spacer()
                Text(dateFormatter.string(from: game.date))
                Spacer()
                HStack {
                    Text("\(game.players.count) / \(game.maxNumPlayers)")
                    Text("@ " + game.location)
                }
                Spacer()
            }
            Spacer()
        }
        .frame(height: 70)
    }
}

struct GameListRowView_Previews: PreviewProvider {
    static let game = Game(date: Date(), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], description: "All ages are welcome", status: .toStart)
    static var previews: some View {
        GameListRowView(game: game)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
