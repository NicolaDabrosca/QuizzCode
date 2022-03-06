//
//  Info.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 25/02/22.
//

import Foundation
import SwiftUI
struct infopower: View {
    var body: some View {
     
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .padding(4)
//                    .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color.color2, lineWidth: 4)
//                    .padding(4)
//                    )

                   
//                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .accentColor, .blue]), startPoint: .top, endPoint: .bottom))
                
                    .frame(width: UIScreen.main.bounds.size.width*0.9, height: UIScreen.main.bounds.size.height*0.55)
                VStack(alignment: .leading){
                    Text("Come usare i powerup?")
                        .bold()
                        .font(.title)
                        .foregroundColor(Color.color3)
                        .frame(alignment: .top)
                    HStack{Image("return")
                        Text("Return:")
                        .bold()
                        .font(.title3)
                        .foregroundColor(Color.color2)
                        
                    }

//                        .foregroundColor(Color(red: 54/255, green: 112/255, blue: 246/255))
                    Text("Hai due possibilità,se sbagli puoi riprovare")
                        .foregroundColor(Color.accentColor)
                        
                        .bold()
                    HStack{Image("ifelse")
                    Text("If...else...:")
                        .bold()
                        .font(.title3)
                        .foregroundColor(Color.color2)}
                    Text("Una scommessa sull'avversario,se indovina guadagni 20 punti ma se sbaglia ne perdi 5 ")
                        .foregroundColor(Color.accentColor)
                    
                        .bold()
                           HStack{Image("break")

                    Text("Break:")
                        .bold()
                        .font(.title3)
                               .foregroundColor(Color.color2)}
                    Text("In queso turno l'avversario non puo' utilizzare powerup")
                        .foregroundColor(Color.accentColor)
                    
                        .bold()
                    HStack{Image("loop")

                    Text("Loop:")
                        .bold()
                        .font(.title3)
                        .foregroundColor(Color.color2)}
                    Text("Se l'avversario sbaglia perde 30 punti")
                        .bold()
                        .foregroundColor(Color.accentColor)
                    
                    
                }.padding(.horizontal,50)
                
            }
        
    }
}

