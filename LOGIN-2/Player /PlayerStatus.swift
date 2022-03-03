
import Foundation
import UIKit

enum PlayerStatus: String, Codable {
    case idle
    case attack
    case hit
    
    func image(player: PlayerType) -> UIImage {
        return UIImage(named: "\(player.rawValue)_\(self.rawValue)")!
    }
}
