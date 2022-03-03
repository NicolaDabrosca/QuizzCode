//
//  ContentView.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 09/02/22.
//
import UIKit
import SwiftUI
import AuthenticationServices
//import SwiftletData

import GameKit
import GameKitUI
struct ContentView: View {
    @StateObject var vm = BoardModel()
   @State var user  = User()
    
//    LOGIbN
    let localPlayer = GKLocalPlayer.local  //UTENTE LOCALE
       func authenticateUser() {
           localPlayer.authenticateHandler = { vc, error in
               guard error == nil else {
                   print(error?.localizedDescription ?? "")

                   return
               }
               GKAccessPoint.shared.isActive = false

               nome = localPlayer.displayName
              user.setUser(username: nome)
              user.loginUser()
              user.getFriendsListUser()
           }
       }


 @State var nome:String = ""
@State private var showMatchmaker = false
    @State private var test = false
    @State private var test1 = false
    @State private var loading = true
  
    
    var body: some View {
        NavigationView{ZStack{
          
            LinearGradient(gradient: Gradient(colors: [.black, .accentColor, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
              
        
  
                        
            VStack{
                    
                        Text("Quizz \nCode")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 80))
                    .shadow(color: .black, radius: 20)
             
            
             
                Spacer()
                VStack {Text("Loading...")
                        .bold()
                        .foregroundColor(.white)
                    .font(.largeTitle)}.padding()
                  
                ActivityIndicator()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.white)
                    .scaleEffect(1.5)
                Spacer()
                }
               
               
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            loading = false
                      
                }})
           
   
            if loading == false{
                MatchMakerView(user: $user)
            }
//                  .background(Color.blue)
//            VStack(alignment: .center, spacing: 30){
//            Text("Benveunto \(nome) id perchè non capisco come cazzo si mette il nome")
//            .padding()
////
//                Button("TESTA PUNTI"){
//                    vm.submitScore(-13)
//                }
//            Button("TESTATTT"){
////                startBrowsingForNearbyPlayers()
//
//            }
//                Button("vai nella schermata match"){
//                    test.toggle()
//                }
//                Button("vai nella schermata MainhView"){
//                    test1.toggle()
//                }
//                NavigationLink("See leaderboard", destination: Leaderboard())
//
//                NavigationLink("D-D-D-Duel", destination: MatchMakerView(user: $user))
//
//            }
//
//
//
//
//
//
//                .fullScreenCover(isPresented: $test, onDismiss: didDismiss) {
//                    MatchMakerView(user: $user)
//                            }
//                .fullScreenCover(isPresented: $test1, onDismiss: didDismiss) {
//                    MainView(user: user)
//                            }
        }    }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
//        SE E' CONNESSO APRE SCHERMATA
              .onAppear(perform:authenticateUser
                        
              )
  
        }


    func didDismiss() {
        // Handle the dismissing action.
    }
}

struct ActivityIndicator: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                                .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
    
}
struct puntini: View {
    @State private var aquaBounce = false
    @State private var blueberryBounce = false
    @State private var grapeBounce = false
    @State private var magentaBounce = false
    @State private var strawberryBounce = false
    var body: some View {
    HStack {
        Circle()
            .frame(width: 30, height: 30)
            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
            .offset(y: aquaBounce ? 0 : -300)
            .animation(Animation.interpolatingSpring(stiffness: 170, damping: 5).repeatForever(autoreverses: false))
            .onAppear() {
                self.aquaBounce.toggle()
        }
        
        Circle()
            .frame(width: 30, height: 30)
            .foregroundColor(Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)))
            .offset(y: blueberryBounce ? 0 : -300)
            .animation(Animation.interpolatingSpring(stiffness: 170, damping: 5).repeatForever(autoreverses: false).delay(0.03))
            .onAppear() {
                self.blueberryBounce.toggle()
        }
        
        Circle()
            .frame(width: 30, height: 30)
            .foregroundColor(Color(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)))
            .offset(y: grapeBounce ? 0 : -300)
            .animation(Animation.interpolatingSpring(stiffness: 170, damping: 5).repeatForever(autoreverses: false).delay(0.03*2))
            .onAppear() {
                self.grapeBounce.toggle()
        }
        Circle()
            .frame(width: 30, height: 30)
            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)))
            .offset(y: magentaBounce ? 0 : -300)
            .animation(Animation.interpolatingSpring(stiffness: 170, damping: 5).repeatForever(autoreverses: false).delay(0.03*3))
            .onAppear() {
                self.magentaBounce.toggle()
        }
        
        Circle()
            .frame(width: 30, height: 30)
            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)))
            .offset(y: strawberryBounce ? 0 : -300)
            .animation(Animation.interpolatingSpring(stiffness: 179, damping: 5).repeatForever(autoreverses: false).delay(0.03*4))
            .onAppear() {
                self.strawberryBounce.toggle()
        }
        
       
    }
}
}
