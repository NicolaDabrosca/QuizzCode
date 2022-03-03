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
        levels(lev:3,ricompensa: "Nu cazz",oggetti : [3,8,0,1]),
        levels(lev:4,ricompensa: "Nu cazz",oggetti : [0,10,5,0]),
        levels(lev:5,ricompensa: "Nu cazz",oggetti : [20,20,20,20]),
        levels(lev:6,ricompensa: "Nu cazz",oggetti : [0,0,0,1])]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                
                ForEach(lv, id: \.self){lv in
                    
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white.opacity(1))
                            .frame(width: geometry.size.width * 0.01, height:geometry.size.height * 0.35)
                            .padding(.trailing,geometry.size.width * 0.6)
                            .padding(.bottom,-80)
                        
                        HStack{
                            Text("\(lv.lev)")
                                .foregroundColor(.white)
                                .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.07))
                                .bold()
                            
                            if(livello   >= lv.lev){
                                
                                HStack(spacing: -UIScreen.main.bounds.size.width * 0.1){
                                    
                                    
                                    ZStack{
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.1)
                                        sblocca()
                                            .scaleEffect(UIScreen.main.bounds.size.width * 0.001)
                                    } .frame(width: UIScreen.main.bounds.size.width*0.2)
                                    powerUp(lv:lv)
                                        .scaleEffect(UIScreen.main.bounds.size.width * 0.002)
                                    
                                        .frame(width: UIScreen.main.bounds.size.width*0.6, height: UIScreen.main.bounds.size.height/6)
                                    
                                }.padding(.trailing,geometry.size.width * 0.15)
                                
                            }
                            else{
                                HStack(spacing: -UIScreen.main.bounds.size.width * 0.1){
                                    
                                    ZStack{
                                        Circle()
                                            .fill(Color.gray)
                                            .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.1)
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.white)
                                            .scaleEffect(1.5)
                                    }.frame(width: UIScreen.main.bounds.size.width*0.2)
                                    powerUp(lv:lv)
                                        .scaleEffect(UIScreen.main.bounds.size.width * 0.002)
                                        .frame(width: UIScreen.main.bounds.size.width*0.6, height: UIScreen.main.bounds.size.height/6)
                                    
                                }.padding(.trailing,geometry.size.width * 0.15)
                                
                            }
                            
                            
                            
                        }
                    }.padding(.bottom,UIScreen.main.bounds.size.height * 0.02)
                }.frame(width:geometry.size.width )
                
            }
            
        }.onAppear(perform: {print("LIVELLO:\(livello)")})
    }
    
}
struct powerUp:View{
    @State var lv:levels
    var body: some View{
        
        
        VStack(alignment:.leading, spacing: -UIScreen.main.bounds.size.height * 0.04){
            if (lv.oggetti[0] > 0){
                
                HStack{
                    ZStack{
                        
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.size.width * 0.1, height: UIScreen.main.bounds.size.height * 0.1)
                        Image("break")}
                    Text("\(lv.oggetti[0]) Break")
                        .foregroundColor(.white)
                        .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.05))
                        .bold()
                }
            }
            
            if (lv.oggetti[1] > 0){
                HStack{
                    ZStack{
                        
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.size.width * 0.1, height: UIScreen.main.bounds.size.height * 0.1)
                        Image("ifelse")
                    }
                    Text("\(lv.oggetti[1]) If...Else...")
                        .foregroundColor(.white)
                        .font(.system(size: min(UIScreen.main.bounds.size.width ,UIScreen.main.bounds.size.height) * 0.05))
                        .bold()
                }
            }
            if (lv.oggetti[2] > 0){
                HStack{
                    ZStack{
                        
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.size.width * 0.1, height: UIScreen.main.bounds.size.height * 0.1)
                        Image("loop")
                    }
                    Text("\(lv.oggetti[2]) Loop")
                        .foregroundColor(.white)
                        .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.05))
                        .bold()
                }
            }
            if (lv.oggetti[3] > 0){
                HStack{      ZStack{
                    
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.size.width * 0.1, height: UIScreen.main.bounds.size.height * 0.1)
                    Image("return")
                }
                    Text("\(lv.oggetti[3]) Return")
                        .foregroundColor(.white)
                        .font(.system(size: min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height) * 0.05))
                        .bold()
                }
                //
                //
            }
            
            
            
            
            
        }.frame(width: UIScreen.main.bounds.size.width * 0.8 )
    }
}
struct sblocca:View{
    // Animations: Scale, color change and inner stroke (stroke border)
    @State private var circleSize = 0.0
    @State private var circleInnerBorder = 35
    @State private var circleHue = 200
    
    // Scaling Spring Animation
    @State private var heart = Image(systemName: "lock.open.fill")
    
    // Scale and opacity animations
    @State private var splash = 0.0
    @State private var splashTransparency = 1.0
    
    @State private var scaleHeart = 0.0
    
    // Increase number
    
    @State private var iconColor = Color(.white)
    
    var body: some View {
        
        ZStack {
            HStack {
                ZStack {
                    heart
                        .font(.system(size: 64))
                    
                    Circle()
                        .strokeBorder(lineWidth:  CGFloat(circleInnerBorder))
                        .animation(Animation.easeInOut(duration: 0.5).delay(0.1))
                        .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(.systemPink))
                        .hueRotation(Angle(degrees: Double(circleHue)))
                        .scaleEffect(CGFloat(circleSize))
                        .animation(Animation.easeInOut(duration: 0.5))
                    
                    Image("")
                        .opacity(Double(splashTransparency))
                        .animation(Animation.easeInOut(duration: 0.5).delay(0.25))
                        .scaleEffect(CGFloat(splash))
                        .animation(Animation.easeInOut(duration: 0.5))
                    
                    // Rotated splash
                    Image("splash")
                        .rotationEffect(.degrees(90))
                        .opacity(Double(splashTransparency))
                        .animation(Animation.easeInOut(duration: 0.5).delay(0.2))
                        .scaleEffect(CGFloat(splash))
                        .animation(Animation.easeOut(duration: 0.5))
                }
                
            }
            
            // Filled heart icon
            
            HStack {
                heart
                    .font(.system(size: 64))
                    .scaleEffect(CGFloat(scaleHeart))
                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.25))
                
            }
        } // All views
        .foregroundColor(iconColor)
        .onTapGesture {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                iconColor = Color(.green)
                scaleHeart = 1
                heart = Image(systemName: "checkmark")}
            
            
            circleSize = 1.3
            circleInnerBorder = 0
            circleHue = 300
            splash = 1.5
            splashTransparency = 0.0
        }
    }
    
}
