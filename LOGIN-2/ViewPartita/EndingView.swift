//
//  EndingMatchView.swift
//  LOGIN
//
//  Created by Tery Vezzuto on 17/02/22.
//

import SwiftUI
import GameKit
import GameKitUI

struct EndingMatchView: View {
    @ObservedObject var viewModel = MatchMakingViewModel()
    
    
    @State var foto:UIImage
    @State var foto1:UIImage

    @Binding var user:User
    @ObservedObject var gameViewController = GameViewController()
    var match: GKMatch
    @State var quitta:Bool = false
    var body: some View {
        
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black, .accentColor, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
       
            VStack(alignment: .center, spacing: -UIScreen.main.bounds.size.height*0.01){

                Text("Last round")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                
                HStack{
                    VStack{
                        if gameViewController.gameModel.players[0].displayName == GKLocalPlayer.local.displayName{

                        Image(uiImage: foto)
                            .clipShape(Circle())

                            .scaleEffect(0.3)
                            .frame(width: UIScreen.main.bounds.size.width*0.22, height: UIScreen.main.bounds.size.height*0.1)

                            .shadow(color: .white, radius: 5)
                        }else{  Image(uiImage: foto1)
                                .clipShape(Circle())

                                .scaleEffect(0.3)
                                .frame(width: UIScreen.main.bounds.size.width*0.22, height: UIScreen.main.bounds.size.height*0.1)

                                .shadow(color: .white, radius: 5)}
                        Text("\(gameViewController.gameModel.players[0].displayName)")
                            .bold()
                            .foregroundColor(.white)
                       
                        Text("\(gameViewController.gameModel.players[0].punti )")
                            .bold()
                            .foregroundColor(.white)
                     
                        //                        Text(gameViewController.gameModel.players[0].displayName)
                        //                            .bold()
                    }
                    Spacer()
                        .frame(width: 60)
                    
                    Text("VS")
                        .bold()
                        .foregroundColor(.white)
                    
                    
                    
                    Spacer()
                        .frame(width: 60)
                    
                    VStack{
                        if gameViewController.gameModel.players[1].displayName == GKLocalPlayer.local.displayName{

                        Image(uiImage: foto)
                            .clipShape(Circle())

                            .scaleEffect(0.3)
                            .frame(width: UIScreen.main.bounds.size.width*0.22, height: UIScreen.main.bounds.size.height*0.1)

                            .shadow(color: .white, radius: 5)
                        }else{
                            Image(uiImage: foto1)
                                .clipShape(Circle())

                                .scaleEffect(0.3)
                                .frame(width: UIScreen.main.bounds.size.width*0.22, height: UIScreen.main.bounds.size.height*0.1)

                                .shadow(color: .white, radius: 5)
                        }
                        Text("\(gameViewController.gameModel.players[1].displayName )")
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("\(gameViewController.gameModel.players[1].punti )")
                            .bold()
                            .foregroundColor(.white)
                         
                        //                        Text(gameViewController.gameModel.players[1].displayName)
                        //                            .bold()
                    }
                }.padding(6)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 380, height: 380)
                        .shadow(radius: 10)
                    VStack{
                      
                        if GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName && gameViewController.gameModel.players[1].punti  > gameViewController.gameModel.players[0].punti || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName && gameViewController.gameModel.players[0].punti  > gameViewController.gameModel.players[1].punti {
                            VStack{
                        Text("Congratulations, you won!")
                            .bold()
                            .foregroundColor(.accentColor)
                            .font(.title2)
                            if gameViewController.gameModel.fine == true {
                                Text("L'Avversario si è arreso!")
                                    .bold()
                                    .foregroundColor(.accentColor)
                                    .font(.title2)
                            }
                        
                        Image("win")
                            }.padding(.top,20);
                        }
                        else {
                            VStack{
                            Text("Congratulations, you lose!")
                                .bold()
                                .foregroundColor(.accentColor)
                                .font(.title2)
                            if gameViewController.gameModel.fine == true {
                                Text("Ti sei arreso!")
                                    .bold()
                                    .foregroundColor(.accentColor)
                                    .font(.title2)
                            }
                            
                            Image("defeat")
                            }.padding(.top,20)}
                        
                        
                    }
                }.onAppear{
                    print("APPARE ENDING VIEW *********************")
                    print("")
                    user.printUser()
                    aggiornaStats(user: user)
                    user.updateUserInfo()
                }
                
                VStack{
                    Button(action:{
                        
                            
                        
                            self.viewModel.showMatchMakerModal()
                            GKMatchManager.shared.cancel()
//                        match.rematch(completionHandler: {(newMatch, error) in
//                            print("execute rematch completion handler")
//                            if let error = error {
//                                print(error)
//                            }
//                            if let newMatch = newMatch {
//                                print("rematch completed \(newMatch.players.count)")
//                                self.match = newMatch
//                            }
//                        })
                        
                    },label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 220, height: 80)
                            .shadow(radius: 10)
                        
                        Text("Play again")
                            .bold()
                            .foregroundColor(.blue)
                        
                    
                }
            })
                    Button(action:{
//                        gameViewController.cambiadisconnect()
                        print("PRIMA I AGGIORNARE: *************************")
                    
                      
                                            
                        GKMatchManager.shared.cancel()
               
                    },label:{
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .padding()
                                .foregroundColor(.white)
                                .frame(width: 220, height: 80)
                                .shadow(radius: 10)
                            
                        Text("Quit")
                            .bold()
                            .foregroundColor(.blue)}
                    })
                }
                
            }.frame( alignment: .bottom)
                .sheet(isPresented: self.$viewModel.showModal) {
                    GKMatchmakerView(
                        minPlayers: 2,
                        maxPlayers: 2,
                        inviteMessage: "Let us play together!"
                    ) {
                        self.viewModel.showModal = false
                        self.viewModel.currentState = "Player Canceled"
                    } failed: { (error) in
                        self.viewModel.showModal = false
                        self.viewModel.currentState = "Match Making Failed"
                        self.viewModel.showAlert(title: "Match Making Failed", message: error.localizedDescription)
                    } started: { (match) in
                        self.viewModel.showModal = false

                    }
                 
                }
                .alert(isPresented: self.$viewModel.showAlert) {
                    Alert(title: Text(self.viewModel.alertTitle),
                          message: Text(self.viewModel.alertMessage),
                          dismissButton: .default(Text("Ok")))
                }
            if quitta == true {
                MatchMakerView(user:$user)

            }
        }
        
    }
    
    public func chisei() -> Int{
        if GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName {
           return 1
        }else{return 0}
    }
    
    public func aggiornaStats(user:User){
        let i = chisei()
        var j = 1
        if(i == 1){
            j = 0
        }
        var points = gameViewController.gameModel.players[i].punti
        var rec = user.getUserStruct()[0].record
        var win = user.getUserStruct()[0].win
        var lose = user.getUserStruct()[0].lose
        
        if(rec < points){
            rec = points
        }
        
        if(points > gameViewController.gameModel.players[j].punti){
            win += 1
        }
        else{
            lose += 1
        }
        print("")
        print("WIN FINE: \(win)")
        print("LOSE FINE: \(lose)")
        print("POINTS FINE: \(points)")
        print("RECORD FINE: \(rec)")
       
        user.setUserInfo(points: points, record: rec, win: win, lose: lose)
    }
}



//struct EndingMatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        EndingMatchView()
//    }
//}
