//
//  RechordCodingChallengeApp.swift
//  RechordCodingChallenge
//
//  Created by Dan Wartnaby on 11/04/2022.
//

import SwiftUI

@main
struct RechordCodingChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            RechordView(viewModel: RechordViewModel())
        }
    }
}
