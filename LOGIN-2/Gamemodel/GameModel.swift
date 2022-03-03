//
//  GameModel.swift
//  GameCenterMultiplayer
//
//  Created by   on
//

import Foundation
import UIKit
import GameKit

public struct GameModel: Codable {
    var players: [Player] = []
    var time: Int = 60
    var count: Int = 0
    var connectionstatus:Bool = false
    var fine:Bool = false 
}

extension GameModel {
    func encode() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static func decode(data: Data) -> GameModel? {
        return try? JSONDecoder().decode(GameModel.self, from: data)
    }
}
