//
//  StartGame.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 16/02/22.
//

import Foundation
import SwiftUI
import GameKit


struct StartGame: View {
    private struct Answers: Identifiable {
        let answer: String
        let font: Font
        var id: String { answer }
    }

    private var answers: [Answers] = [
        Answers(answer: ".ignoresSafeAreas()", font: .body),
        Answers(answer: ".zoom()", font: .body ),
        Answers(answer: ".ScaleEffect()", font: .body ),
        Answers(answer: ".bold()", font: .body )
    ].shuffled()
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [Color.color1,Color.color2,Color.color3]), startPoint: .top, endPoint: .bottom)     .ignoresSafeArea()
//            .edgesIgnoringSafeArea(.all)
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.cyan, .accentColor, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                
                Text("Round 1")
                    .bold()
                    .foregroundColor(.white)
//                        .fontWeight(.medium)
                
                Spacer()
                ZStack{
                    Image("questionbackground")
                    
                    Text("How do you zoom Nicola's Image?")
                        .foregroundColor(.accentColor)
                        .font(.title2)
                        .bold()

                }

                Spacer()
                
                ZStack{
                    Image("rectangleanswers")
                        .padding(100)
                    
                    VStack{
                        
                        ForEach(answers) { answers in
                            
                            
                            Button(action:{}) {
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                         .padding(4)
                                        .foregroundColor(.white)
                                        .frame(width: 380, height: 90)
                                    
                                    Text(answers.answer)
                                }
                            }
                        }
                        
                    }
                }
               
            }
        }

       
    }
    
    
}
extension Color {
    static let color1 = Color("Color1")
    static let color2 = Color("Color2")
    static let color3 = Color("Color3")

}
