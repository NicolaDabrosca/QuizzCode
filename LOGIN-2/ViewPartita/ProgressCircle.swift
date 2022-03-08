//
//  ProgressCircle.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 25/02/22.
//

import Foundation
import SwiftUI
import GameKit
import GameKitUI
struct ProgressCircle: View {

    var body: some View {
        ZStack {
            //            if self.backgroundEnabled {
            //                Circle()
            //                    .stroke(lineWidth: self.lineWidth)
            //                    .foregroundColor(Color.red)
            //                    .opacity(0.6)
            //            }
            
            Text("\(Int(value))")
                .font(.system(size: 35, weight: .bold, design: .default))
            
            Circle()

                .trim(from: 0, to: CGFloat(self.value/20))
                .stroke(style: self.style.strokeStyle(lineWidth: self.lineWidth))

                .animation(.linear(duration: 0.01), value:true)

//                .animation(.easeOut(duration: 10), value:true)
                .foregroundColor(Color.white)
                .opacity(0.8)
                .rotationEffect(Angle(degrees: -90))
//                .animation(.easeOut(duration: 10), value:true)
            
            //                .animation(.easeIn)
        }
    }
    enum Stroke {
        case line
        case dotted
        
        func strokeStyle(lineWidth: CGFloat) -> StrokeStyle {
            switch self {
            case .line:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round)
            case .dotted:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round,
                                   dash: [12])
            }
        }
    }
    
    private let value: Double
    private let maxValue: Double
    private let style: Stroke
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let lineWidth: CGFloat
    
    init(
        value: Double,
         maxValue: Double,
         style: Stroke = .line,
         backgroundEnabled: Bool = true,
         //         backgroundColor: Color = Color(UIColor(red: 245/255,
         //                                                green: 245/255,
         //                                                blue: 245/255,
         //                                                alpha: 1.0)),
         backgroundColor: Color = Color.blue,
         foregroundColor: Color = Color.black,
         lineWidth: CGFloat = 10) {
        self.value = value
        self.maxValue = maxValue
        self.style = style
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.lineWidth = lineWidth
    }
}

