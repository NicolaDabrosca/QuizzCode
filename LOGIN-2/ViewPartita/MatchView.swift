//
//  MatchView.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 14/02/22.
//

//
//  MatchView.swift
//  Runatar-test
//
//  Created by Giuseppe Carannante on 13/02/22.
//
import UIKit
import Foundation
import SwiftUI
import GameKit
import GameKitUI


struct MatchView: View {
    @ObservedObject var gameViewController = GameViewController()
    var match: GKMatch
    @State var loading: Bool = true
    @State var temp: Bool = false
    @State var fine: Bool = false
    @State var ingrandisci:Bool = false
    @State var player1 = Player()
    @State var player2 = Player()
    @State var returno:Bool = true
    @State var domande:Questions = Questions()
    @State  var correct:Bool = false
    @State  var disattivapot:Bool = false
    @State var naccCristo = [false,false,false,false]
    @State var progress:CGFloat = 60
    @State var info:Bool = false
    @State var attaccato:Bool = false
    @State var aggiorna:Color = .white
    public struct Answers: Identifiable {
        let answer: String
        let font: Font
        var id: String { answer }
        var indovinato:Bool
        @State var playing1:Int
    }
    
    @State var disattiva:Bool = false
    @State var progressValue: Float = 0.0
    @State var answers: [Answers] = []
    @State var user  = User()
    @State var quantity: [Int] = []
    @State public var timero: Timer!
    @State var power1 = false
    @State var power2 = false
    @State var power3 = false
    @State var power4 = false
    @State var chiseitu:Int = 2
    @State var foto = UIImage()
    @State var foto1 = UIImage()
    @State var ohmamma:Bool = false
    public init(_ match: GKMatch) {
        self.match = match
        user.setUser(username: GKLocalPlayer.local.displayName)
        user.loginUser()
        
    }
    
    public func tempo() {
        timero = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timero) in
            progress -= 0.01
            
        }
        )}
   
   
    var body: some View {

        NavigationView {
            ZStack {
                
                //               SFONDO
                LinearGradient(gradient: Gradient(colors: [.black, .accentColor, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.bottom)
                    .onAppear{
                        
                        gameViewController.passamatch(match: match)
                        //             gameViewController.initTimer()
                        gameViewController.viewDidLoad()
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)){
                            loading = false
//                            foto = GKLocalPlayer.local.loadPhotoForSize(.normal, withCompletionHandler: {
//                                       (image, error) in
//
//                                       var playerInformationTuple:(playerID:String,alias:String,profilPhoto:UIImage?)
//                                       playerInformationTuple.profilPhoto = nil
//
//                                       playerInformationTuple.playerID = EGC.localPayer.playerID!
//                                       playerInformationTuple.alias = EGC.localPayer.alias!
//                                       if error == nil { playerInformationTuple.profilPhoto = image }
//                                       completionTuple(playerInformationTuple: playerInformationTuple)
//
//                                   })
                            Task{     await foto = try  GKLocalPlayer.local.loadPhoto(for: .small)
                                await foto1 = try  match.players.first?.loadPhoto(for: .small) as! UIImage
                            }

                            answers = [
                                Answers(answer: domande.questions[gameViewController.gameModel.count].r1, font: .body,indovinato: false,playing1:1),
                                Answers(answer: domande.questions[gameViewController.gameModel.count].r2, font: .body ,indovinato:false,playing1:2),
                                Answers(answer: domande.questions[gameViewController.gameModel.count].answer, font: .body ,indovinato:true,playing1:0),
                                Answers(answer: domande.questions[gameViewController.gameModel.count].r3, font: .body ,indovinato:false,playing1:3)
                            ].shuffled()
                            
                        }
                    }.padding(.top,80)
                
                VStack{
                    
                    //                    UNA VOLTA CHE HO CARICATO APRO TUTTO
                    if (loading == false){
                        
                        
                        VStack {
                            //                            ROUND CON COUNT
                            HStack(spacing:120){     Text("\(gameViewController.gameModel.count+1)/10")
                                    .bold()
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(alignment: .top)
                         
                                Button {
                                    ohmamma.toggle()
                                    var i = chisei()
                                    var j = 1
                                    if(i == 1){
                                        j = 0
                                    }
                                    gameViewController.punisciQuitter(i: i, j: j)
                                } label: {
                                    Image(systemName: "flag.fill")
                                        .foregroundColor(.white)
                                }

                            }.padding(.leading,150)
                            
                            //                            UTENTI E PUNTI
                            HStack{
                                VStack{
                                    Image(uiImage: foto)
                                        .scaleEffect(0.4)
                                        .frame(width: 100, height: 100)

//
                                    
                                        Text(gameViewController.gameModel.players[0].displayName )
                                        .bold()
                                        .foregroundColor(.white)
                                    Text("\(gameViewController.gameModel.players[0].punti )")
                                        .bold()
                                        .foregroundColor(attaccato && gameViewController.gameModel.players[0].displayName  == gameViewController.gameModel.players[chisei()].displayName ? aggiorna : .white)
                                        .animation(.easeOut(duration: 1),value : attaccato )
                                        .scaleEffect(attaccato && gameViewController.gameModel.players[0].displayName == gameViewController.gameModel.players[chisei()].displayName ? 1.3 : 1)
                                        .animation(.easeOut(duration: 1),value : attaccato )

                                        .font(.largeTitle)
                                }
                                
                                
                                
                                VStack{ ProgressCircle(value: Double(gameViewController.gameModel.time),
                                                       maxValue: Double(progress),
                                                       style: .line,
                                                       foregroundColor: Color.white,
                                                       lineWidth: 20)
                                    
                                        .scaleEffect(0.6)
                                    
                                    .frame(width:150,height: 150)}
                                VStack{
                                    Image(uiImage: foto1)
                                        .scaleEffect(0.4)
                                        .frame(width: 100, height: 100)
                                    Text(gameViewController.gameModel.players[1].displayName)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text("\(gameViewController.gameModel.players[1].punti)")
                                        .font(.largeTitle)
                                    
                                        .bold()

                                       
                                        .foregroundColor(attaccato && gameViewController.gameModel.players[1].displayName  == gameViewController.gameModel.players[chisei()].displayName ? aggiorna : .white)
                                    
                                    .scaleEffect(attaccato && gameViewController.gameModel.players[1].displayName == gameViewController.gameModel.players[chisei()].displayName ? 1.3 : 1)
                                    .animation(.easeOut(duration: 1),value : attaccato )
                                    
                                }
                            }
                        

                           
                            
                            
                            
//
//
//
//
//
                            //                        DOMANDE
//
//
//
//
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .foregroundColor(.white)
                                    .frame(width: 420, height: 120)
                                    .shadow(radius: 10)
                                
                                Text(domande.questions[gameViewController.gameModel.count].text)
                                    .foregroundColor(.accentColor)
                                    .font(.title2)
                                    .bold()
                                    .onChange(of: domande.questions[gameViewController.gameModel.count].text) { newValue in
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)){
                                            disattivapot = false
                                            progress = 60
                                            naccCristo = [false,false,false,false]
                                            disattiva = false
                                            power1 = false
                                            power2 = false
                                            power3 = false
                                            
                                            power4 = false
                                            
                                            answers = [
                                                Answers(answer: domande.questions[gameViewController.gameModel.count].r1, font: .body,indovinato: false,playing1:1),
                                                Answers(answer: domande.questions[gameViewController.gameModel.count].r2, font: .body ,indovinato:false,playing1:2),
                                                Answers(answer: domande.questions[gameViewController.gameModel.count].answer, font: .body ,indovinato:true,playing1:0),
                                                Answers(answer: domande.questions[gameViewController.gameModel.count].r3, font: .body ,indovinato:false,playing1:3)
                                            ].shuffled()}
                                    }
                                
                                
                                
                            }
                            
                            Spacer()
                            
                            
                            ZStack{
                                Image("rectangleanswers")
                                    .padding(100)
                                
                                VStack{
                                    //                                RISPOSTE
                                    
                                    ForEach(answers) { answers in
                                        if (answers.indovinato){
                                           
                                            
                                            //STO PER SCRIVERE UN TREMENDO PEZZO DI CODICE MA PER MO NON HO ALTERNATIVE
                                            Button(action:{
                                                gameViewController.buttonAttackPressed()
                                                //                                                answers.playing1.toggle()
                                                naccCristo[answers.playing1].toggle()
                                                aggiorna = .green
//                                                if returno == true{
//                                                    returno = false
//
//                                                }
                                                disattiva = true
                                                attaccato = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)){
                                                    attaccato = false
                                                    aggiorna = .white
                                                }
                                                
                                            },label: {
                                                ZStack{
                                                    //                                                //                                                    DemoView(testo: answers.answer,correct:correct)
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .padding(4)
                                                        .foregroundColor( naccCristo[answers.playing1] ? Color.green : Color.white)
                                                        .animation(.easeInOut(duration: 0.5), value:  naccCristo[answers.playing1])
                                                        .frame(width: 380, height: 70)
                                                        .shadow(radius: 10)
                                                    HStack{
                                                        //                Image(systemName: playing ? "pause" : "play")
                                                        Text(answers.answer)
                                                            .bold()
                                                    }
                                                    .foregroundColor( naccCristo[answers.playing1] ? Color.white : Color.color2 )
                                                    
                                                    
                                                }
                                                //                                                DemoView(correct: $naccCristo[answers.playing1], testo: answers.answer)
                                            })
                                                .disabled(disattiva)
                                            
                                        }
                                        else {
                                            Button(action:
                                                    {
                                                
                                                
                                                attaccato = true
                                                aggiorna = .red
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)){
                                                    attaccato = false
                                                    aggiorna = .white
                                                }
                                                naccCristo[answers.playing1] = true
                                                disattiva = true
                                                print("TOGGLE:\(naccCristo[answers.playing1])")
                                                if returno == true{
                                                    gameViewController.buttonAttackPressed1()
                                                    disattiva = true
                                                  
                                                }
                                                else { gameViewController.buttonAttackPressed2()
                                                    returno = true
                                                    disattiva = false
                                                    
                                                }
                                                //
                                                
                                            },label:{
                                                //
                                                ZStack{
                                                    
                                                    //
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .padding(4)
                                                        .foregroundColor(naccCristo[answers.playing1] ? Color.red : Color.white)
                                                        .animation(.easeInOut(duration: 0.5), value: naccCristo[answers.playing1])
                                                        .frame(width: 380, height: 70)
                                                        .shadow(radius: 10)
                                                    HStack{
                                                        Text(answers.answer)
                                                            .bold()
                                                    }
                                                    .foregroundColor(naccCristo[answers.playing1] ? Color.white : Color.color2 )
                                                    //                                                    Text(answers.answer)
                                                }.disabled(disattiva)
                                            }).disabled(disattiva)
                                        }
                                        //
                                        
                                        
                                    }
                                    
                                }
                            }
//
//
//                            Powerup
//
//
//                            
                                
                            HStack{
                                Button(action: {returno = false
                                    disattivapot = true
                                    power1 = true
                                    if(user.quantity[3] > 0){
                                        user.quantity[3] -= 1
                                    }
                                }, label: {
                                    ZStack{  if( gameViewController.gameModel.players[1].isbreak == false || gameViewController.gameModel.players[0].isbreak == false )
                                        {
                                        RoundedRectangle(cornerRadius: 20)

                                        
                                            .fill( Color.blue )
                                        RoundedRectangle(cornerRadius: 20)

                                            .stroke(Color.white, lineWidth: 4)

                                            .frame(width: 80, height: 80)
                                        Text("Return")
                                            .foregroundColor( Color.white)
                                    }
                                        if(GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&  gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true )
                                        {
                                            RoundedRectangle(cornerRadius: 20)

                                                .fill(Color.black)
                                                .opacity( 0.6 )

                                                .frame(width: 80, height: 80)
                                            Text("Return")
                                                .foregroundColor(.white)
                                            
                                            //                                            Text("\(user.quantity[2])")
                                        }
                                        
                                        if power1 == true {
                                            RoundedRectangle(cornerRadius: 20)

                                                .fill(Color.white)
                                                .scaleEffect(1.1)

                                                .frame(width: 80, height: 80)
                                            Text("Return")
                                                .foregroundColor(.color2)
                                        }
                                    }
                                }).disabled(disattivapot || gameViewController.gameModel.players[1].isbreak || gameViewController.gameModel.players[0].isbreak )
                                Button(action: {gameViewController.buttonifelsepressed()
                                    disattivapot = true
                                    power2 = true
                                    if(user.quantity[1] > 0){
                                        user.quantity[1] -= 1
                                    }
                                }, label: {
                                    ZStack{  if( gameViewController.gameModel.players[1].isbreak == false || gameViewController.gameModel.players[0].isbreak == false ){
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill( Color.blue )
                                        
                                    RoundedRectangle(cornerRadius: 20)

                                        .stroke(Color.white, lineWidth: 4)
                                      
                                            .frame(width: 80, height: 80)
                                        Text("If...else...")
                                            .foregroundColor(Color.white)

                                    }
                                        if( GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&  gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true )
                                        {
                                            RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill(Color.black)
                                                .opacity(0.6)

                                                .frame(width: 80, height: 80)
                                            Text("If...else...")
                                                .foregroundColor(.white)
                                            
                                            //                                            Text("\(user.quantity[2])")
                                        }
                                        
                                        if power2 == true {
                                            RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill(Color.white)
                                                .scaleEffect(1.1)

                                                .frame(width: 80, height: 80)
                                            Text("If...else...")
                                                .foregroundColor(.color2)
                                            
                                        }
                                        
                                    }
                                }).disabled(disattivapot || gameViewController.gameModel.players[1].isbreak || gameViewController.gameModel.players[0].isbreak )
                                Button(action: {gameViewController.buttonbreakpressed()
                                    disattivapot = true
                                    power3 = true
                                    if(user.quantity[0] > 0){
                                        user.quantity[0] -= 1
                                    }
                                    
                                }, label: {
                                    ZStack{
                                        
                                        if( gameViewController.gameModel.players[1].isbreak == false || gameViewController.gameModel.players[0].isbreak == false ){
                                            RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill(Color.blue)
                                            
                                        RoundedRectangle(cornerRadius: 20)

                                            .stroke(Color.white, lineWidth: 4)
                                                .frame(width: 80, height: 80)
                                            Text("Break")
                                                .foregroundColor( Color.white )

                                            //                                            Text("\(user.quantity[0])")
                                        }
                                        if(GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&   gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true )
                                        {
                                            RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill(Color.black)
                                                .opacity(0.6)

                                                .frame(width: 80, height: 80)
                                            Text("Break")
                                                .foregroundColor(.white)
                                            
                                            //                                            Text("\(user.quantity[0])")
                                            
                                        }
                                        if power3 == true {
                                            RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill(Color.white)
                                                .frame(width: 80, height: 80)
                                                .scaleEffect(1.1)

                                            Text("Break")
                                                .foregroundColor(.color2)
                                            
                                        }
                                    }
                                }).disabled(disattivapot || gameViewController.gameModel.players[1].isbreak || gameViewController.gameModel.players[0].isbreak )
                                Button(action: {gameViewController.buttonloopoepressed()
                                    disattivapot = true
                                    power4 = true
                                    if(user.quantity[2] > 0){
                                        user.quantity[2] -= 1
                                    }
                                }, label: {
                                    ZStack{
                                        
                                        if( gameViewController.gameModel.players[1].isbreak == false || gameViewController.gameModel.players[0].isbreak == false ){  RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill( Color.blue )
                                            
                                        RoundedRectangle(cornerRadius: 20)

                                            .stroke(Color.white, lineWidth: 4)
                                                .frame(width: 80, height: 80)
                                            Text("Loop")
                                                .foregroundColor(Color.white)

                                        }
                                        if(GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&  gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true )
                                        {
                                            RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill(Color.black)
                                                .opacity(0.6)

                                                .frame(width: 80, height: 80)
                                            Text("Loop")
                                                .foregroundColor(.white)
                                            
                                            //                                            Text("\(user.quantity[2])")
                                        }
                                        if power4 == true {
                                            RoundedRectangle(cornerRadius: 20)
                                            
                                                .fill(Color.white)
                                                .frame(width: 80, height: 80)
                                                .scaleEffect(1.1)
//                                            animation(.easeOut(duration:0.5),value : power4)
                                            Text("Loop")
                                                .foregroundColor(.color2)
                                            
                                        }
                                    }
                                    
                                }).disabled(disattivapot || gameViewController.gameModel.players[1].isbreak || gameViewController.gameModel.players[0].isbreak )
                                Button(action: {info = true}, label: {Text("?")
                                        .bold()
                                        .foregroundColor(Color.white)
                                        .font(.title)
                                        .frame(alignment: .top)
                                }).padding(.bottom,50)
                             
                                
                            }.padding(.leading,20)
                            
                            //                            }
                            
                        }.padding(.horizontal)

                        .toolbar {
                            ToolbarItemGroup {
                                Button(action: {
                                    aggiornaStats(user: user)
                                    user.updateUserInfo()
                                    GKMatchManager.shared.cancel()
                                    
                                    
                                }) {
                                    
                                }}
                            //                    }
                        }.padding(.bottom,100)
                    }
                    
                    
                    
                    
                }.padding(.top,100)
                    .navigationBarHidden(true)
                if gameViewController.disconnected == true {
                    EndingMatchView(foto:foto,foto1:foto1,user: $user, gameViewController: gameViewController, match: match)
                    
                }
                
                if (info == true ){
                    infopower()
                    .padding(.top,170)
                }
                if (ohmamma == true){
                    EndingMatchView(foto:foto,foto1:foto1,user: $user, gameViewController: gameViewController, match: match)

                }
            }.onTapGesture {
                info = false
            }
            
        } .preferredColorScheme(.dark)
    }
    public func aggiornaStats(user:User){
        var i = 0
        var j = 1
        if(gameViewController.gameModel.players[1].displayName == user.usernameLocal){
            i = 1
            j = 0
        }
        let punti = gameViewController.gameModel.players[i].punti
        var rec = user.getUserStruct()[0].record
        var win = user.getUserStruct()[0].win
        var lose = user.getUserStruct()[0].lose
        if(user.getUserStruct()[0].record < punti){
            rec = punti
        }
        if(punti < gameViewController.gameModel.players[j].punti){
            lose += 1
        }else{
            win += 1
        }
        user.setUserInfo(points: punti, record: rec, win: win, lose: lose)
        
    }
    
    public func chisei() -> Int{
        if GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName {
           return 1
        }else{return 0}
    }
    
}


