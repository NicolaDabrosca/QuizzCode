//
//  MatchView_Model.swift
//  LOGIN
//
//  Created by Nicola D'Abrosca on 14/02/22.
//

//
//  Match_Model.swift
//  Runatar-test
//
//  Created by Giuseppe Carannante on 13/02/22.
//

import Foundation
import SwiftUI
import GameKit

class MatchMakingViewModel: ObservableObject {
    
    @Published public var showModal = false
    @Published public var showAlert = false
    @Published public var alertTitle: String = ""
    @Published public var alertMessage: String = ""
    @Published public var currentState: String = "Loading GameKit..."

    public init() {
    }
    
    public func load() {
        self.showMatchMakerModal()
    }

    public func showAlert(title: String, message: String) {
        self.showAlert = true
        self.alertTitle = title
        self.alertMessage = message
    }

    public func showMatchMakerModal() {
        self.showModal = true
        
    }
}
