//
//  GameViewController.swift
//  GameCenterMultiplayer
//
//  Created by Pedro Contine on 29/06/20.
//

import UIKit
import GameKit
import SwiftUI
import GameKitUI
class GameViewController: UIViewController , ObservableObject{
    
 

    var match: GKMatch?
    public var timer: Timer!
    public var disconnected: Bool = false
    public var temp: Bool = false
    @Published private(set)  var gameModel: GameModel!
    {
        didSet {
////            updateUI()
        }
    }
    
    public func punisciQuitter(i:Int,j:Int) {
       gameModel.players[i].punti = gameModel.players[j].punti - 1

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        gameModel = GameModel()
        match?.delegate = self
        
        print("Viewdidoload OK")
        savePlayers()
        if getLocalPlayerType() == .one, timer == nil {
            self.initTimer()
        }
    }
    public func  cambiadisconnect(){
  
        GKMatchManager.shared.cancel()
        self.disconnected = true

    }
    public func passamatch(match: GKMatch){
        self.match = match
        print("Set match OK")
    }
    public func initTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            let player = self.getLocalPlayerType()
            if player == .one, self.gameModel.time >= 1 {
                self.gameModel.time -= 1
                self.sendData()
            }
        })
    }
    
    private func savePlayers() {
        guard let player2Name = match?.players.first?.displayName else { return }
        let player1 = Player(displayName: GKLocalPlayer.local.displayName)
        let player2 = Player(displayName: player2Name)
        
        gameModel.players = [player1, player2]
        
        gameModel.players.sort { (player1, player2) -> Bool in
            player1.displayName < player2.displayName
        }
        
        sendData()
        print("Salva OK")
    }
    
    public func getLocalPlayerType() -> PlayerType {
        if gameModel.players.first?.displayName == GKLocalPlayer.local.displayName {
            return .one
        } else {
            return .two
        }
    }

    public func esci(){
      match?.disconnect()
    }
//    private func updateUI() {
//        guard gameModel.players.count >= 2 else { return }
//
//        print(gameModel.players[1].displayName)
//        let player = getLocalPlayerType()
//    }
    
    @IBAction func buttonAttackPressed() {
        let localPlayer = getLocalPlayerType()
        
        //Change status to attacking
        gameModel.players[localPlayer.index()].punti += 10
        self.gameModel.players[localPlayer.index()].risposto = true
print("RISPOSTA\(self.gameModel.players[localPlayer.index()].risposto)")
        if localPlayer.index() == 1 && self.gameModel.players[1].ifelse == true{ self.gameModel.players[0].punti += 20 }
        if localPlayer.index() == 0 && self.gameModel.players[0].ifelse == true{self.gameModel.players[1].punti += 20
            
        }
    
        
        sendData()
        
        //Reset status after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sendData()
        }
        print("Attacco OK")
    }
//    DA CANCELLARE IN FUTURO RICORDA
    @IBAction func buttonAttackPressed1() {
        let localPlayer = getLocalPlayerType()
        
        //Change status to attacking
        gameModel.players[localPlayer.index()].punti -= 5
        self.gameModel.players[localPlayer.index()].risposto = true
print("RISPOSTA\(self.gameModel.players[localPlayer.index()].risposto)")
        if localPlayer.index() == 1 && self.gameModel.players[1].ifelse == true{ self.gameModel.players[0].punti += -5 }
        if localPlayer.index() == 0 && self.gameModel.players[0].ifelse == true{self.gameModel.players[1].punti += -5
            
        }
        if localPlayer.index() == 1 && self.gameModel.players[1].loopo == true{ self.gameModel.players[1].punti -= 45 }
        if localPlayer.index() == 0 && self.gameModel.players[0].loopo == true{self.gameModel.players[0].punti -= 45
            
        }
        sendData()
        
        //Reset status after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sendData()
        }
        print("Attacco OK")
    }
    @IBAction func buttonAttackPressed2() {
        let localPlayer = getLocalPlayerType()
        
        //Change status to attacking
        gameModel.players[localPlayer.index()].punti -= 0
        self.gameModel.players[localPlayer.index()].risposto = true
print("RISPOSTA\(self.gameModel.players[localPlayer.index()].risposto)")
        sendData()
        
        //Reset status after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sendData()
        }
        print("Attacco OK")
    }
    @IBAction func buttonbreakpressed() {
        
        let localPlayer = getLocalPlayerType()
        if localPlayer.index() == 1{
        //Change status to attacking
            self.gameModel.players[0].isbreak.toggle()}
        else { self.gameModel.players[1].isbreak.toggle()}
//        self.gameModel.players[localPlayer.index()].risposto = true
print("Break\(self.gameModel.players[localPlayer.index()].isbreak)")
        sendData()
        
        //Reset status after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sendData()
        }
        print("Attacco OK")
    }
    
    @IBAction func buttonifelsepressed() {
        
        let localPlayer = getLocalPlayerType()
        if localPlayer.index() == 1{
        //Change status to attacking
            self.gameModel.players[0].ifelse.toggle()}
        else { self.gameModel.players[1].ifelse.toggle()}
//        self.gameModel.players[localPlayer.index()].risposto = true
print("Break\(self.gameModel.players[localPlayer.index()].isbreak)")
        sendData()
        
        //Reset status after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sendData()
        }
        print("Attacco OK")
    }
    @IBAction func    disattivabottone(i:Int){
      self.gameModel.players[i].disabled = true
    }
    @IBAction func buttonloopoepressed() {
        
        let localPlayer = getLocalPlayerType()
        if localPlayer.index() == 1{
        //Change status to attacking
            self.gameModel.players[0].loopo.toggle()}
        else { self.gameModel.players[1].loopo.toggle()}
//        self.gameModel.players[localPlayer.index()].risposto = true
print("Break\(self.gameModel.players[localPlayer.index()].isbreak)")
        sendData()
        
        //Reset status after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sendData()
        }
        print("Attacco OK")
    }
//
//
//
//
    
    private func sendData() {
        guard let match = match else { return }
        
        do {
            guard let data = gameModel.encode() else { return }
            try match.sendData(toAllPlayers: data, with: .reliable)
            print("Message sent!")
            print(gameModel.players[0].punti)
            print(gameModel.players[1].punti)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if(self.gameModel.players[0].risposto == true && self.gameModel.players[1].risposto == true || self.gameModel.time == 0){
                    self.gameModel.time = 60
                    self.gameModel.count += 1
                   
                        self.gameModel.players[1].isbreak = false
                        self.gameModel.players[0].isbreak = false
                    self.gameModel.players[1].ifelse = false
                    self.gameModel.players[0].loopo = false
                    self.gameModel.players[1].loopo = false
                        self.gameModel.players[0].ifelse = false
                    
                self.gameModel.players[0].risposto = false
                    self.gameModel.players[1].risposto = false}
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    if (self.gameModel.count == 9) {
//                    GKMatchManager.shared.cancel()
//                    print("qua finisce\(disconnected)")
                    self.disconnected = true
                        print( "Poor gabbiano\(self.disconnected = true)")
//                    print("qua finisce\(disconnected)")
                }
           
                }
            }
        } catch {
      
                print("Send data failed")}
       
    }
}

extension GameViewController: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        guard let model = GameModel.decode(data: data) else { return }
        gameModel = model
        print("Dati mandati")
    }
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        switch (state)
            {
                case GKPlayerConnectionState.connected:
                    print("CONNESSO")

                case GKPlayerConnectionState.disconnected:
            
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        GKMatchManager.shared.cancel()
                     disconnessione = true
print("CANCELL : \(disconnessione)")
                    }

                default:
                    print("state unknown")
            }
    }
}
