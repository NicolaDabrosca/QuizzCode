//
//  ScriìollView.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 02/03/22.
//
import SwiftUI
import Foundation
public struct levels:Hashable{
    var lev:Int
    var ricompensa:String
    var oggetti:[Int]
}
struct Scrolla: View {

    @State var livello:Int
    var lv:[levels] = [
        levels(lev:1,ricompensa: "Nu cazz",oggetti : [2,1,0,0]),
        levels(lev:2,ricompensa: "Nu cazz",oggetti : [8,8,3,2]),
        levels(lev:3,ricompensa: "Nu cazz",oggetti : [3,0,0,1]),
        levels(lev:4,ricompensa: "Nu cazz",oggetti : [0,10,5,0]),
        levels(lev:5,ricompensa: "Nu cazz",oggetti : [20,20,20,20]),]
    
    
    var body: some View {
        GeometryReader { geometry in
        ScrollView(.vertical){
         
            ForEach(lv, id: \.self){lv in
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white.opacity(1))
                        .frame(width: geometry.size.width * 0.03, height:geometry.size.height * 0.33)
                        .padding(.trailing,geometry.size.width * 0.6)
                    
                    HStack{
                        Text("")
                            .frame(width: geometry.size.width * 0.26)
                        Text("\(lv.lev)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                        
                        if(livello  >= lv.lev){
                           
                            HStack{
                               

                                Circle()
                                    .fill(Color.white)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.1)
                                
                                powerUp(lv:lv)
                                  
                                    .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/6)

                            }.padding(.trailing,geometry.size.width * 0.4)
                               
                    }
                        else{
                            HStack{    Circle()
                                    .fill(Color.black)
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.1)
                                powerUp(lv:lv)
                                    .scaleEffect(1)

                                       .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/6)

                            }.padding(.trailing,geometry.size.width * 0.6)
                            
                        }
                        
                        
                        
                    }
                }
            }.frame(width:geometry.size.width )
           
        }
            
        }.onAppear(perform: {print("LIVELLO:\(livello)")})
    }
    
}
struct powerUp:View{
    @State var lv:levels
    var body: some View{
        
           
                VStack{
                    if (lv.oggetti[0] > 0){
                        HStack{
                            Image("break")
                                .scaleEffect(1.5)
                            Text("\(lv.oggetti[0]) Break")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                        }
                    }

                    if (lv.oggetti[1] > 0){
                        HStack{ Image("ifelse")
                                .scaleEffect(1.5)

                            Text("\(lv.oggetti[1]) If...Else...")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                    if (lv.oggetti[2] > 0){
                        HStack{
                            Image("loop")
                                .scaleEffect(1.5)

                            Text("\(lv.oggetti[2]) Loop")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                    if (lv.oggetti[3] > 0){
                        HStack{ Image("return")
                                .scaleEffect(1.5)

                            Text("\(lv.oggetti[3]) Return")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                        }
                        //
                        //
                    }



                

            }
    }
}
