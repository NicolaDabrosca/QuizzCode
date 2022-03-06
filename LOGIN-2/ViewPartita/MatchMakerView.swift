import SwiftUI
import GameKit
import GameKitUI
public var disconnessione:Bool = false
prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
struct MatchMakerView: View {
    @ObservedObject var viewModel = MatchMakingViewModel()
    @ObservedObject var gameViewController = GameViewController()
    @State var fine:Bool = false
    @Binding var user:User
    @State var searchText = ""
    @State var change:Bool = false
    func didDismiss() {
        // Handle the dismissing action.
    }
   @State var fototab:[String] = ["profilo2","corona2","home"]
    @State var foto:UIImage = UIImage()
    @State var tabSelected = 0
    let tabIcons = ["home", "livelli", "profileview"]
    var body: some View {
        TabView(selection: $tabSelected){
            VStack{
                //                Categorie
                Text("Play in a category")
                    .bold()
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(alignment: .leading)
                    .padding(.bottom)
                
                    
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Button(action:{self.viewModel.showMatchMakerModal()
                            
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .frame(width: 130, height: 160)
                                    .shadow(radius: 6)
                                
                                VStack{
                                    Image("arkit")
                                    
                                    
                                    Text("ARKit")
                                        .foregroundColor(.color3)
                                        .bold()
                                    
                                }
                            }
                        }.padding()
                        Spacer()
                            .frame(width: 6)
                        
                        VStack{
                            
                            Button(action:{self.viewModel.showMatchMakerModal()
                                
                            }) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                        .frame(width: 130, height: 160)
                                        .shadow(radius: 6)
                                    
                                    VStack{
                                        Image("uikit")
                                        
                                        
                                        Text("UI Kit")
                                            .foregroundColor(.color3)
                                            .bold()
                                        
                                    }
                                }
                            }.padding()
                            
                            Button(action:{self.viewModel.showMatchMakerModal()}) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                        .frame(width: 130, height: 160)
                                        .shadow(radius: 6)
                                    VStack{
                                        Image("gamekit")
                                        
                                        Text("GameKit")
                                            .foregroundColor(.color3)
                                            .bold()
                                            .fontWeight(.semibold)
                                        
                                    }
                                }
                            }
                        }.padding(.top, 50)
                        
                        Spacer()
                            .frame(width: 6)
                        
                        VStack{
                            Button(action:{self.viewModel.showMatchMakerModal()}) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                        .frame(width: 130, height: 160)
                                        .shadow(radius: 6)
                                    VStack{
                                        Image("swiftui")
                                        
                                        
                                        Text("SwiftUI")
                                            .foregroundColor(.color3)
                                            .bold()
                                        
                                    }
                                }
                            }.padding()
                            
                            Button(action:{self.viewModel.showMatchMakerModal()}) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                        .frame(width: 130, height: 160)
                                        .shadow(radius: 6)
                                    
                                    VStack{
                                        Image("cloudkit")
                                        
                                        Text("CloudKit")
                                            .foregroundColor(.color3)
                                            .bold()
                                        
                                    }
                                }
                            }
                        }.padding(.bottom, 50)
                        Button(action:{self.viewModel.showMatchMakerModal()
                            
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .frame(width: 130, height: 160)
                                    .shadow(radius: 6)
                                
                                VStack{
                                    Image("coredata")
                                    
                                    
                                    Text("Core Data")
                                        .foregroundColor(.color3)
                                        .bold()
                                    
                                }
                            }
                        }.padding()
                        Spacer()
                            .frame(width: 6)
                    }
                }
                
                Spacer()
                    .frame(height: 60)
                
                Button(action: {self.viewModel.showMatchMakerModal()
                }){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .frame(width: 316, height: 80)
                            .shadow(radius: 6)
                        
                        HStack{
                            Spacer()
                                .frame(width: 20)
                            Text("Quick Battle")
                                .foregroundColor(Color.color3)
                                .bold()
                                .font(.title2)
                                .padding()
                            Image("fulmine")
                            //                                    .frame(alignment: .trailing)
                                .padding()
                        }
                        
                    }
                    
                }
                Spacer()
                    .frame(height: 10)
                
                
                
            }.frame( maxHeight: .infinity, alignment: .center)
//                .padding(.bottom,UIScreen.main.bounds.size.height*0.09)
                .tabItem{
                    
                    Image("\(fototab[2])")
                        .resizable()
                        .frame(width: 30, height: 31)
                        .scaleEffect(tabSelected == 0 ? 1.5 : 1)
                }.tag(0)
                .background(LinearGradient(gradient: Gradient(colors: [.black, .accentColor]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all))
            
            LevelsView(user:user,livello: user.getUserStruct()[0].level).tabItem{
                
                Image("\(fototab[1])")
                    .resizable()
                    .frame(width: 35, height: 23)
                    .scaleEffect(tabSelected == 1 ? 1.5 : 1)

                //                    .padding()

            }.tag(1)
            
            Profilo(foto: foto, user:$user,userStruct: user.getUserStruct()[0]).tabItem{
                
                Image("\(fototab[0])")
//                    .resizable()

                //                                .scaledToFit()
                    .frame(width: 26, height: 30)
                //                    .padding()
            }.tag(2)
              
                .background(LinearGradient(gradient: Gradient(colors: [.black, .accentColor]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all))

            //            if gameViewController.disconnected == true {
            //                print("EPICO SOUNDTRACK")
            //                EndingMatchView(user: $user, gameViewController: gameViewController)
            
            //            }
            
        }

        .onAppear{print("EPICOO \(disconnessione))")
            Task{     await foto = try  GKLocalPlayer.local.loadPhoto(for: .small)}

        }
        .onChange(of:tabSelected){_ in
            print("tabbar \(tabSelected)")
            if tabSelected == 2 {
                fototab[0] = "profileview"
                fototab[1] = "corona2"
                fototab[2] = "spada2"
            }
            if tabSelected == 1{
                fototab[0] = "profilo2"
                fototab[1] = "livelli"
                fototab[2] = "spada2"

            }
            if tabSelected == 0{
                fototab[0] = "profilo2"
                fototab[1] = "corona2"
                fototab[2] = "home"


            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
            .background(LinearGradient(gradient: Gradient(colors: [.black, .accentColor]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all))
        }
        .alert(isPresented: self.$viewModel.showAlert) {
            Alert(title: Text(self.viewModel.alertTitle),
                  message: Text(self.viewModel.alertMessage),
                  dismissButton: .default(Text("Ok")))
        }
        
        
    }
    
    
    
}

