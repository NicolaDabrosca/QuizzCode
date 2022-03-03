//
//  Leaderboard.swift
//  Runatar-test
//
//  Created by Giuseppe Carannante on 13/02/22.
//

import SwiftUI

struct Leaderboard: View {
    @StateObject var vm = BoardModel()
    
    var body: some View {
        List {
                    ForEach(vm.topScores ?? [], id: \.self) { item in
                        HStack {
                            Text(item.player.displayName)
                            Spacer()
                            Text(item.formattedScore)
                        }
                    }
                }
                .onAppear {
                    vm.load()
                }
    }
    
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard()
    }
}
