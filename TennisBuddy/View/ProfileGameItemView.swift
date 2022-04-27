//
//  ProfileGameItemView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/26.
//

import SwiftUI

class ProfileGameItemViewModel {
    let user: User
    let game: Game
    let status: Int
    let oppo: User
    let userRepo = UserRepository.instance
    
    init(user: User, game: Game) {
        self.user = user
        self.game = game
        let oppoId = game.owner == user.uid ? game.opponent! : game.owner
        oppo = userRepo.fetchUser(uid: oppoId)!
        switch game.status {
        case .ownerWin:
            status = game.owner == user.uid ? 1 : 0
        case .oppoWin:
            status = game.owner == user.uid ? 0 : 1
        default:
            status = -1
        }
    }
}

struct ProfileGameItemView : View {
    let vm: ProfileGameItemViewModel
    let dateFormatter = DateFormatter()
    
    init(user: User, game: Game) {
        vm = ProfileGameItemViewModel(user: user, game: game)
    }
    
    var body: some View {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return HStack {
            Spacer()
            VStack {
                Spacer()
                Text(dateFormatter.string(from: vm.game.date))
                Spacer()
                switch vm.status {
                case 1:
                    Text("Won")
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                case 0:
                    Text("Lost")
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                default:
                    Text("Missing")
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                Spacer()
            }
            Spacer()
            
            Text("V.S.")
            
            VStack(spacing: 4) {
                Image("DefaultAvatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.horizontal)
                Text(vm.oppo.username)
                    .font(.system(size: 14))
            }
            .padding(.trailing, 14)
        }
        .frame(height: 70)
    }
}

//struct ProfileGameItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileGameItemView()
//    }
//}
