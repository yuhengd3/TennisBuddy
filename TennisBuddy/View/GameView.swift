//
//  GameView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("PrincetonOrange"))
                        .ignoresSafeArea()
                        .frame(height: 80)
                        
                    Text("Games")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                Spacer()

            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color("PrincetonOrange"))
                            .font(.system(size: 56))
                            .padding()
                            //.padding(.bottom, 7)
                    })
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
