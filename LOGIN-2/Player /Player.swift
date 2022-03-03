//
//  Player.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 09/02/22.
//
////
import Foundation
import Swift
import UIKit
import GameKit


struct Player: Codable {
    var displayName: String = ""
    var punti: Int = 0
    var risposto: Bool = false
    var isbreak:Bool = false
    var ifelse:Bool = false
    var loopo:Bool = false
    var disabled:Bool = false
}
enum PlayerType: String, Codable, CaseIterable {
    case one
    case two
}

extension PlayerType {
    func enemyIndex() -> Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 0
        }
    }
    
    func index() -> Int {
        switch self {
        case .one:
            return 0
        case .two:
            return 1
        }
    }
    
 
}
