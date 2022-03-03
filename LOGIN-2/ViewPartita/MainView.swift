////
////  MainView.swift
////  LOGIN
////
////  Created by Nicola D'Abrosca on 17/02/22.
////
//
//import Foundation
//import SwiftUI
//import GameKit
//import GameKitUI
//
//struct MainView: View {
//    var user  = User()
//    var amici:[String] = []
//    init (user:User){
//        self.user = user
//
//    }
//    @State var searchText = ""
//    @ObservedObject var viewModel = MatchMakingViewModel()
//
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .top) {//               GRADIENTE
//                LinearGradient(gradient: Gradient(colors: [.cyan, .accentColor, .purple]), startPoint: .top, endPoint: .bottom)
//                    .edgesIgnoringSafeArea(.all)
//                VStack{
//                    HStack( ){
//                        Text("Battle")
//                            .bold()
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .padding()
//                        Spacer()
//                           NavigationLink(destination: LevelsView()){
//                                Image("livelli")
//                            }
//                    
//                        NavigationLink(destination: Profilo(user: user)){
//                            Image("Nicola").scaleEffect(0.5)
//                         }
//            //            Nascondi icona
//                        .onAppear(perform: {GKAccessPoint.shared.isActive = false})
//                        
//                        
//                    }.padding(.top)
//                    
////              FINISCHE HSTACK INIZIA RANDOM BATTLE
//                    Button(action: {self.viewModel.showMatchMakerModal()
//}){
//                    ZStack{
//             
//                                                             RoundedRectangle(cornerRadius: 20)
//                                                            
//                                                                 .foregroundColor(.white)
//                                                                 .frame(width: 380, height: 120)
//                                                                 .opacity(0.6)
//                        HStack{
//                            Text("Random Battle")
//                                .foregroundColor(Color.color3)
//                        }
//                                                         }
//                    
//                    }.padding(.bottom)
//                    //                Finisce RandomBattle Inizia amici e aggiungi
//                    HStack{
//                        Text("Friends")
//                            .bold()
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .padding()
//                        
//                        Spacer()
//                        
//                        Button(action: {}) {
//                            Image("addFriends")
//                                .padding()
//                        }
//                       
////
////                        .sheet(isPresented: $showingSheetFriends) {
////                            AddFriendsView()
////                        }
//                    }
//                    //                Inizia Searchbar
//                                    HStack(spacing:10) {
//                                        
//                                        Image("searchbar")
//                                        .padding()
//                                        
//                                        
//                                    TextField("Search", text:$searchText)
//                                    }
//                                        .padding(.vertical, 1)
//                                        .padding(.horizontal)
//                                        .background(Color.white.opacity(0.5))
//                                        .cornerRadius(12)
//                                        .padding(.horizontal)
//                    //                Inizia lista amici
//
//                                    ScrollView(.vertical){
//                                    
//                                    
//                    //
//                    //                ForEach(amici) { answers in
//                    //
//                    //                    {
//                    //                                            ZStack{
//                    //
//                    //                                                RoundedRectangle(cornerRadius: 20)
//                    //                                                     .padding(4)
//                    //                                                    .foregroundColor(.white)
//                    //                                                    .frame(width: 380, height: 90)
//                    //
//                    //                                                Text("")
//                    //                                            }
//                    //                                        }
//                    //
//                    //}
//                    //
//                                    }
//                }.padding(.bottom)
//
//            }
//            
//        }  .sheet(isPresented: self.$viewModel.showModal) {
//            GKMatchmakerView(
//                minPlayers: 2,
//                maxPlayers: 2,
//                inviteMessage: "Let us play together!"
//            ) {
//                self.viewModel.showModal = false
//                self.viewModel.currentState = "Player Canceled"
//            } failed: { (error) in
//                self.viewModel.showModal = false
//                self.viewModel.currentState = "Match Making Failed"
//                self.viewModel.showAlert(title: "Match Making Failed", message: error.localizedDescription)
//            } started: { (match) in
//                self.viewModel.showModal = false
//
//            }
//         
//        }
//        .alert(isPresented: self.$viewModel.showAlert) {
//            Alert(title: Text(self.viewModel.alertTitle),
//                  message: Text(self.viewModel.alertMessage),
//                  dismissButton: .default(Text("Ok")))
//        }
//           
//    }
//}
//
//
//
//
