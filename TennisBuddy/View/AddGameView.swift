//
//  AddGameView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/10.
//

import SwiftUI

struct AddGameView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
                    .font(.system(size: 22))
                    .padding()
                //Spacer()
                Text("New Game")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundColor(Color("PrincetonOrange"))
                    .font(.system(size: 22))
                    .padding()
            }
            
            Spacer()
        }
    }
}

struct AddGameView_Previews: PreviewProvider {
    static var previews: some View {
        AddGameView()
    }
}
