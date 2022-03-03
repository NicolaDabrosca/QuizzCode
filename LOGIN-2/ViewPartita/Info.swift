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
                    .foregroundColor(.blue)
                    .padding(4)
                    .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.color2, lineWidth: 4)
                    .padding(4)
                    )

                   
//                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .accentColor, .blue]), startPoint: .top, endPoint: .bottom))
                
                    .frame(width: 369, height: 380)
                VStack(alignment: .leading){
                    Text("Come funzionano i powerup?")
                        .bold()
                        .foregroundColor(Color.color2)

//                        .foregroundColor(Color(red: 54/255, green: 112/255, blue: 246/255))
                        .font(.largeTitle)
                        .frame(alignment: .top)
                    Text("Return:")
                        .bold()
                        .foregroundColor(Color.color2)

//                        .foregroundColor(Color(red: 54/255, green: 112/255, blue: 246/255))
                    Text("Hai due possibilità,se sbagli puoi riprovare")
                        .foregroundColor(Color.white)
                    
                        .bold()
                    Text("If...else...:")
                        .bold()
                        .foregroundColor(Color.color2)
                    Text("Una scommessa sull'avversario,se indovina guadagni 20 punti ma se sbaglia ne perdi 5 ")
                        .foregroundColor(Color.white)
                    
                        .bold()
                    Text("Break:")
                        .bold()
                        .foregroundColor(Color.color2)
                    Text("In queso turno l'avversario non puo' utilizzare powerup")
                        .foregroundColor(Color.white)
                    
                        .bold()
                    Text("Loop:")
                        .bold()
                        .foregroundColor(Color.color2)
                    Text("Se l'avversario sbaglia perde 50 punti")
                        .bold()
                        .foregroundColor(Color.white)
                    
                    
                }.padding(.horizontal,50)
                
            }
        
    }
}
