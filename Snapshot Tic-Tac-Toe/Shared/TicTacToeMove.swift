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
    var board               :[Int] = [4,4,4,4,4,4,4,4,4] // 1 is green boarder, 2 is X, 3 is O, 4 is blank
    var comment             :String = "X moves first."
    var index               :Int = 0
    
    init() {
        self.id = UUID()
        self.board = [4,4,4,4,4,4,4,4,4]
        self.comment = "X moves first."
        self.index = 0
    }
    
    init(id: UUID, board: [Int], comment: String, index: Int) {
        self.id = id
        self.board = board
        self.comment = comment
        self.index = index
    }
    
    init(copyBoard: TicTacToeMove) {
        self.id = UUID()
        self.board = Array(copyBoard.board)
        self.comment = String(copyBoard.comment)
        self.index = Int(copyBoard.index)
    }
}
