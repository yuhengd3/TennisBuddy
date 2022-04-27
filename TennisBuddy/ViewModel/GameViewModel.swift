//
//  GameViewModel.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/26.
//

import Foundation
import Combine

class GameViewModel : ObservableObject {
    @Published var gameRepo = GameRepository.instance
    @Published var userRepo = UserRepository.instance
    
    var cancellable : AnyCancellable?
    
    init() {
        self.cancellable = self.gameRepo.$games.sink(
            receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            }
        )
        
//        self.cancellable = self.userRepo.$users.sink(
//            receiveValue: { [weak self] _ in
//                self?.objectWillChange.send()
//            }
//        )
    }
    
    func createGame(_ game: Game) {
        gameRepo.createGame(game)
    }

}
