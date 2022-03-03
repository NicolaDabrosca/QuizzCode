//
//  LevelsView.swift
//  Quiz Code
//
//  Created by Tery Vezzuto on 15/02/22.
//

import SwiftUI

struct LevelsView: View {
    //    @Binding var user:User
    @State var livello:Int
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.black, .accentColor]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    HStack{
                        Text("Levels \(livello)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .frame(     width: UIScreen.main.bounds.size.width/2)
                        Text("")
                            .frame(     width: geometry.size.width * 0.60)
                    }
                    
                    .frame(width:geometry.size.height*0.15)
                    Scrolla(livello:livello)
                        .frame(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height * 0.7)
                    
                }.edgesIgnoringSafeArea(.all)
                
                    .padding(.bottom,UIScreen.main.bounds.size.height * 0.22)

            } .frame(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height)
        }.navigationBarBackButtonHidden(true)
        
    }
}
