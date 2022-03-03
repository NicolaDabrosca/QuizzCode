

import SwiftUI

struct Profilo: View {
    @State var foto:UIImage
    @Binding var user:User
    @State var userStruct:User.UserStruct
    @State private var selectedView = "Details"
    @State private var selected = ["Details", "Recents"]
    let powerup = ["loop","break", "ifelse", "return"]
    var body: some View {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.black, .accentColor]), startPoint: .top, endPoint: .bottom)

                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("My profile")
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(alignment: .bottom)
                    
                    Spacer()
                        .frame(height: 30)
                    Image(uiImage: foto)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Text(userStruct.username)
                        .bold()
                        .foregroundColor(.white)
                    HStack{
                    Image("livelli")
                        .resizable()
                        .frame(width: 35, height: 23)
                        
                        Text("4")
                            .bold()
                            .foregroundColor(.white)
                    }.frame(alignment:.center)
                    
                    HStack{
                        ForEach(powerup, id: \.self) { powerup in
                            ZStack{
                                
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 54, height: 54)
                            .padding()
                                
                                Image(powerup)
                                VStack{
                                    Spacer()
                                        .frame(height: 44)
                                    HStack{
                                        Spacer()
                                            .frame(width: 18)
                                    ZStack{
                                Circle()
                                    .foregroundColor(.color2)
                                    .frame(width: 22, height: 22)
                                    
                                Text("10")
                                .bold()
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                                    }.padding(.leading)
                                    }
                                }
                            }
                        }
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 290)

                                VStack{
                                    
                                    Text("Punti totali: \(userStruct.points)")
                                        .bold()
                                        .foregroundColor(.color3)
                                        .font(.system(size: 26))
                                   
                                   Divider()
                                        .frame(height: 10)
                                    Text("Record:  \(userStruct.record)")
                                        .bold()
                                        .foregroundColor(.color3)
                                        .font(.system(size: 26))
                                   
                                    Divider()
                                        .frame(height: 10)
                                    Text("Vittorie: \(userStruct.win)")
                                        .bold()
                                        .foregroundColor(.color3)
                                        .font(.system(size: 26))
                                    
                                    Divider()
                                        .frame(height: 10)
                                    Text("Perdite: \(userStruct.lose)")
                                        .bold()
                                        .foregroundColor(.color3)
                                        .font(.system(size: 26))
                                }
                            //                        Form {
                            //                                  Section(
                            ////                                    footer: Text("Note: Enabling logging may slow down the app")
                            //                                  ) {
                            //                                      Picker("Select a color", selection: $selectedView) {
                            //                                          ForEach(selected, id: \.self) {
                            //                                              Text($0)
                            //                                          }
                            //                                      }    .foregroundColor(.white)
                            //                                      .pickerStyle(SegmentedPickerStyle())
                            //                    }
                            //
                            //                        }.frame(width: 300, height: 400)
                       Spacer()
                           
                        
                    }.onAppear {
                        userStruct = user.getUserStruct()[0]
                        
                    }
                }
        }

    }}
//struct EndingMatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        Profilo(user:$user,userStruct: user.getUserStruct()[0]))
//    }
//}
