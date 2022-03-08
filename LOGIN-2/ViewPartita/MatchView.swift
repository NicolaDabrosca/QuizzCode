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
import AVFoundation

struct MatchView: View {
    @State var audioPlayer: AVAudioPlayer!

    func playSounds(_ soundFileName : String) {
           guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: nil) else {
               fatalError("Unable to find \(soundFileName) in bundle")
           }

           do {
               audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
           } catch {
               print(error.localizedDescription)
           }
           audioPlayer.play()
       }
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
    @State var progress:CGFloat = 20
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
    @State  var showingAlert = false

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
            gameViewController.debugga()
            print("debugga")
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
                        
                        VStack{
                        VStack {
                            //                            ROUND CON COUNT
                            HStack(){
                        
                                Button {
                                    showingAlert = true
                         
                                } label: {
                                    Image(systemName: "flag.fill")
                                        .foregroundColor(.white)
                                        .scaleEffect(1.2)

                                }
                                Spacer(minLength:UIScreen.main.bounds.size.width*0.5)
                                    .frame(width: UIScreen.main.bounds.size.width*0.7)
                                Button {
                                    info = true
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                        .scaleEffect(1.5)
                                }
//                                .padding(.leading, -UIScreen.main.bounds.size.width * 0.85)
                            }
                                .alert("Sei sicuro di voler abbandonare?", isPresented: $showingAlert) {
                                            Button("No", role: .cancel) { }
                                    Button("Quit"){           ohmamma.toggle()
                                        var i = chisei()
                                        var j = 1
                                        if(i == 1){
                                            j = 0
                                        }
                                        gameViewController.punisciQuitter(i: i, j: j)
                                        
                                    }
                                        }
                            
                            //                            UTENTI E PUNTI
                            HStack{
                                VStack{
                                    if gameViewController.gameModel.players[0].displayName == GKLocalPlayer.local.displayName{
                                        Image(uiImage: foto)
                                            .clipShape(Circle())

                                            .scaleEffect(0.3)

                                            .frame(width: UIScreen.main.bounds.size.width*0.23, height: UIScreen.main.bounds.size.height*0.1)
                                    }else{Image(uiImage: foto1)
                                            .clipShape(Circle())

                                            .scaleEffect(0.3)
                                            .frame(width: UIScreen.main.bounds.size.width*0.23, height: UIScreen.main.bounds.size.height*0.1)
                                    }
                                      
                                     
                                    
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
                                    
                                        .font(.title)
                                }
                                
                                
                                
                                VStack(spacing: -UIScreen.main.bounds.size.height * 0.015){ ProgressCircle(value: Double(gameViewController.gameModel.time),
                                                       maxValue: Double(progress),
                                                       style: .line,
                                                       foregroundColor: Color.white,
                                                       lineWidth: 12)
                                    
                                        .scaleEffect(0.8)
                                    
                                    .frame(width: UIScreen.main.bounds.size.width*0.20, height: UIScreen.main.bounds.size.height*0.20)
                                    Text("\(gameViewController.gameModel.count+1)/10")
                                            .bold()
                                            .foregroundColor(.white)
                                            .font(.largeTitle)
                                            .frame(alignment: .center)
                                }
                                VStack{
                                    if gameViewController.gameModel.players[0].displayName == GKLocalPlayer.local.displayName{
                                        Image(uiImage: foto1)
                                            .clipShape(Circle())

                                            .scaleEffect(0.3)
                                    
                                            .frame(width: UIScreen.main.bounds.size.width*0.23, height: UIScreen.main.bounds.size.height*0.1)
                                    }else{Image(uiImage: foto)
                                            .clipShape(Circle())

                                            .scaleEffect(0.3)

                                            .frame(width: UIScreen.main.bounds.size.width*0.23, height: UIScreen.main.bounds.size.height*0.1)
                                    }
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
//                                    .foregroundColor(.white.opacity(0.3))
                                                                    .foregroundColor(.white)

                                    .frame(width: UIScreen.main.bounds.size.width*0.9, height: UIScreen.main.bounds.size.height*0.09)
                                    .shadow(radius: 10)
                                
                                Text(domande.questions[gameViewController.gameModel.count].text)
//                                    .foregroundColor(.white)
                                                                    .foregroundColor(.accentColor)

                                    .bold()
                                    .font(.title2)
                                    .minimumScaleFactor(0.0003)
                                       .lineLimit(2)
                                       .frame(width: UIScreen.main.bounds.size.width*0.88, height: UIScreen.main.bounds.size.height*0.09)
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
                                
                                
                                
                            }}.padding(.bottom,-UIScreen.main.bounds.size.height*0.2)
                            
           
                            
//                            DOMANDE""
                       
                            VStack(spacing:-UIScreen.main.bounds.size.height*0.045){
                                VStack{
                                    Spacer()
                                        .frame(height: UIScreen.main.bounds.height*0.02)
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
//                                                self.playSound(sound: "correct", type: "mp3")
                                       
                                                playSounds("correct.wav")

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
                                                        .frame(width: UIScreen.main.bounds.size.width*0.89, height: UIScreen.main.bounds.size.height*0.08)
                                                        .shadow(radius: 10)
                                                    HStack{
                                                        //                Image(systemName: playing ? "pause" : "play")
                                                        Text(answers.answer)

                                                            .bold()
                                                            .minimumScaleFactor(0.0003)
                                                               .lineLimit(2)
                                                               .frame(width: UIScreen.main.bounds.size.width*0.88, height: UIScreen.main.bounds.size.height*0.08)
                                                    }
                                                    .foregroundColor( naccCristo[answers.playing1] ? Color.white : Color.accentColor )
                                             
                                                    if disattiva == true {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(Color.green, lineWidth: 4)
                                                            .frame(width: UIScreen.main.bounds.size.width*0.86, height: UIScreen.main.bounds.size.height*0.075)
                                                            
                                                    }
                                                    
                                                }
                                                //                                                DemoView(correct: $naccCristo[answers.playing1], testo: answers.answer)
                                            })
                                                .disabled(disattiva)
                                            
                                        }
                                        else {
                                            Button(action:
                                                    {
                                                
                                                playSounds("wrong.wav")

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
                                                        .frame(width: UIScreen.main.bounds.size.width*0.9, height: UIScreen.main.bounds.size.height*0.08)
                                                        .shadow(radius: 10)
                                                    HStack{
                                                        Text(answers.answer)

                                                            .bold()
                                                            .minimumScaleFactor(0.0003)
                                                               .lineLimit(2)
                                                               .frame(width: UIScreen.main.bounds.size.width*0.88, height: UIScreen.main.bounds.size.height*0.08)
                                                    }
                                                    .foregroundColor(naccCristo[answers.playing1] == true ? Color.white : Color.accentColor )
                                                    //                                                    Text(answers.answer)
                                                }.disabled(disattiva)
                                                    
                                            }).disabled(disattiva)
                                                
                                        }
                                        //
                                        
                                        
                                    }
                                    
                                }
                            .padding(.top,UIScreen.main.bounds.size.height * 0.2)
                                Spacer(minLength: UIScreen.main.bounds.size.height * 0.1)
//
//
//                            Powerup
//
//
//                            
                            VStack{
                            HStack{
                                Button(action: {returno = false
                                    disattivapot = true
                                    power1 = true
                                    if(user.quantity[3] > 0){
                                        user.quantity[3] -= 1
                                    }
                                }, label: {
                                    ZStack{
                                        //                                        normale
                                        if( gameViewController.gameModel.players[1].isbreak == false || gameViewController.gameModel.players[0].isbreak == false )
                                        {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("return")
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[3])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                        }
                                        //                                        se breakkato
                                        if(GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&  gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true || user.quantity[3] == 0)
                                        {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.3))
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("return")
                                                    .opacity(0.2)
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.secondary)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[3])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                            
                                            //                                            Text("\(user.quantity[2])")
                                        }
                                        //                                        quando premi
                                        if power1 == true {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .shadow(color: .color2, radius: 14)
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("return")
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[3])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }.scaleEffect(1.3)
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
                                        
                                        ZStack{
                                            Circle()
                                                .foregroundColor(.white)
                                                .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                .padding()
                                            
                                            Image("ifelse")
                                            VStack{
                                                Spacer()
                                                    .frame(height: UIScreen.main.bounds.height*0.044)
                                                HStack{
                                                    Spacer()
                                                        .frame(width: UIScreen.main.bounds.width*0.06)
                                                    ZStack{
                                                        Circle()
                                                            .foregroundColor(.color2)
                                                            .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                        
                                                        Text("\(user.quantity[1])")
                                                            .bold()
                                                            .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                            .foregroundColor(.white)
                                                            .shadow(color:.accentColor,radius: 4)
                                                    }.padding(.leading)
                                                }
                                            }
                                        }
                                        
                                    }
                                        if( GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&  gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true || user.quantity[1] == 0)
                                        {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.3))
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("ifelse")
                                                    .opacity(0.2)
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                            .frame(width: 18)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[1])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                            
                                            //                                            Text("\(user.quantity[2])")
                                        }
                                        
                                        if power2 == true {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .shadow(color: .color2, radius: 14)
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("ifelse")
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[1])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }.scaleEffect(1.3)
                                            
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
                                        
                                        if( gameViewController.gameModel.players[1].isbreak == false || gameViewController.gameModel.players[0].isbreak == false )
                                        {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("break")
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[0])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                            
                                            //                                            Text("\(user.quantity[0])")
                                        }
                                        if(GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&   gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true || user.quantity[0] == 0 )
                                        {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.3))
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("break")
                                                    .opacity(0.2)
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[0])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                            
                                            //                                            Text("\(user.quantity[0])")
                                            
                                        }
                                        if power3 == true {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .shadow(color: .color2, radius: 14)
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("break")
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[0])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }.scaleEffect(1.3)
                                            
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
                                        
                                        if( gameViewController.gameModel.players[1].isbreak == false || gameViewController.gameModel.players[0].isbreak == false )
                                        {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("loop")
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[2])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                            
                                        }
                                        if(GKLocalPlayer.local.displayName == gameViewController.gameModel.players[1].displayName &&  gameViewController.gameModel.players[1].isbreak == true || GKLocalPlayer.local.displayName == gameViewController.gameModel.players[0].displayName &&  gameViewController.gameModel.players[0].isbreak == true || user.quantity[2] == 0)
                                        {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.3))
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("loop")
                                                    .opacity(0.2)
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[2])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                            
                                            //                                            Text("\(user.quantity[2])")
                                        }
                                        if power4 == true {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .shadow(color: .color2, radius: 14)
                                                    .frame(width: UIScreen.main.bounds.size.width*0.15, height: UIScreen.main.bounds.size.height*0.08)
                                                    .padding()
                                                
                                                Image("loop")
                                                VStack{
                                                    Spacer()
                                                        .frame(height: UIScreen.main.bounds.height*0.044)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width: UIScreen.main.bounds.width*0.06)
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.color2)
                                                                .frame(width: UIScreen.main.bounds.size.width*0.055, height: UIScreen.main.bounds.size.height*0.055)
                                                            
                                                            Text("\(user.quantity[2])")
                                                                .bold()
                                                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.035))
                                                                .foregroundColor(.white)
                                                                .shadow(color:.accentColor,radius: 4)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }.scaleEffect(1.3)
                                            
                                        }
                                    }
                                    
                                }).disabled(disattivapot || gameViewController.gameModel.players[1].isbreak || gameViewController.gameModel.players[0].isbreak )
                            
                             
                                
                            }.padding(.bottom,-UIScreen.main.bounds.size.height*0.05)
//                                Button(action: {info = true}, label: {
//                                ZStack{
//
//                                RoundedRectangle(cornerRadius: 16)
//                                        .foregroundColor(.color2)
//                                        .frame(width: UIScreen.main.bounds.size.width*0.1, height: UIScreen.main.bounds.size.height*0.04, alignment: .center)
//                                Text("?")
//                                    .bold()
//                                    .foregroundColor(Color.white)
//                                    .font(.title)
//                                    .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.095))
//                                    .frame(alignment: .center)
//                                }
//                                }).padding(.bottom,-UIScreen.main.bounds.size.height*0.03)
                            }.padding(.bottom,UIScreen.main.bounds.size.height*0.05)
                            //                            }
                            
                            }}

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
                        .padding(.top,UIScreen.main.bounds.size.height*0.27)
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


