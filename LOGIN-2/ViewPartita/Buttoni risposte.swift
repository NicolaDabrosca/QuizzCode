//
//  Buttoni risposte.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 23/02/22.
//

import Foundation
import SwiftUI
import GameKit
import GameKitUI
struct DemoView: View {

    @Binding var correct:Bool
    @State var testo:String
    var body: some View {
       
            HStack{
//                Image(systemName: playing ? "pause" : "play")
                Text(testo)
                    .bold()
            }.frame(width: 350, height: 30)
            .background(
                RoundedRectangle(cornerRadius: 25).fill(Color.green)
                    
                    .frame(width: 400, height: 80, alignment: .leading)
                    .blur(radius: 3)
                    .offset(x: correct ? 0 : -400, y: 0)
                    .animation(.easeInOut(duration: 0.3), value: correct)
            )
            .padding()
            .foregroundColor(correct ? Color.white : Color.color2 )
            .background(Color.white)
            .cornerRadius(25)
            .clipped()
            .shadow(radius: 20)
        
    }
}
struct DemoView1: View {
    @ObservedObject var gameViewController = GameViewController()

    var match: GKMatch
    @State private var playing = false
    @State var testo:String
    @State var returno:Bool
    @State  var disattiva:Bool
    @State  var loading:Bool

    var body: some View {
        Text("")
            .onAppear(perform: { DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)){
                self.loading = false
            }})
        if self.loading == true{
        Button(action: { playing.toggle()
            gameViewController.buttonAttackPressed()
  
                if returno == true{
                    returno.toggle()
                }
                if GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName {
                    gameViewController.disattivabottone(i:1)
                    self.disattiva = gameViewController.gameModel.players[1].disabled
                }else{gameViewController.disattivabottone(i:0)
                    self.disattiva = gameViewController.gameModel.players[0].disabled
                }
        }) {
            HStack{
//                Image(systemName: playing ? "pause" : "play")
                Text(testo)
                    .bold()
            }.frame(width: 350, height: 30)
            .background(
                RoundedRectangle(cornerRadius: 25).fill(Color.green)
                    
                    .frame(width: 400, height: 80, alignment: .leading)
                    .blur(radius: 3)
                    .offset(x: playing ? 0 : -400, y: 0)
                    .animation(.easeInOut(duration: 0.3), value: playing)
            )
            .padding()
            .foregroundColor(playing ? Color.white : Color.color2 )
            .background(Color.white)
            .cornerRadius(25)
            .clipped()
            .shadow(radius: 20)
        }}
    }
}
