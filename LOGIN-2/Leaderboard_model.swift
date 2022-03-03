//
//  Leaderboard_model.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 14/02/22.
//
//
//  Leadeboard_Model.swift
//  Runatar-test
//
//  Created by Giuseppe Carannante on 13/02/22.
//

import Foundation
import GameKit

class BoardModel: ObservableObject {
    private var board: GKLeaderboard?
    @Published var localPlayerScore: GKLeaderboard.Entry?
    @Published var topScores: [GKLeaderboard.Entry]?
    
    func load() {
        if nil == board {
            GKLeaderboard.loadLeaderboards(IDs: ["quizzcodepoint"]) { [weak self] (boards, error) in
                self?.board = boards?.first
                self?.updateScores()
            }
        } else {
            self.updateScores()
        }
    }
    
    func updateScores() {
        board?.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 10),
                              completionHandler: { [weak self] (local, entries, count, error) in
            DispatchQueue.main.async {
                self?.localPlayerScore = local
                self?.topScores = entries
            }
        })
    }
    
    func submitScore(_ score: Int){
        let bestScoreInt = GKScore(leaderboardIdentifier: "quizzcodepoint")
        bestScoreInt.value = Int64(score)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }
    }
}

