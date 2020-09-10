//
//  GameComposition.swift
//  RPS-Game
//
//  Created by 游宗諭 on 2020/9/10.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import Foundation
struct GameComposition {
    typealias ViewController = GameViewController
    init(game: RPSGame) {
        gameViewModel = GameViewModel(game: game)
    }
    let gameViewModel: GameViewModel
    
    func rootViewController() -> ViewController {
        let vc = GameViewController(gameViewModel: gameViewModel)
        return vc
    }
}
