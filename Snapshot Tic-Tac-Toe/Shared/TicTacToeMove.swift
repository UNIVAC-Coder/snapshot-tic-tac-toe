//
//  TicTacToeMove.swift
//  Snapshot Tic-Tac-Toe
//  Creative Commons Attribution 4.0 International Public License
//  Creative Commons may be contacted at creativecommons.org.
//
//  Copyright (c) 2021 Thomas Cavalli
//  Thomas Cavalli may be contacted at thomascavalli.com
//
//  List of What Changed (by Who and When):
//  Created by Thomas Cavalli on 11/4/21.
//

import Foundation

class TicTacToeMove: Identifiable, Codable {
    
    var id                  :UUID = UUID()
    var board               :String = "         >         "
    var comment             :String = "X moves first."
    
    init() {
        self.id = UUID()
        self.board = "         >         "
        self.comment = "X moves first."
    }
    
    init(id: UUID, board: String, comment: String) {
        self.id = id
        self.board = board
        self.comment = comment
    }
    
    init(copyBoard: TicTacToeMove) {
        self.id = UUID()
        self.board = String(copyBoard.board)
        self.comment = String(copyBoard.comment)
    }
}
