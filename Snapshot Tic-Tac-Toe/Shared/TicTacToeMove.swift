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
    var board               :[Int] = [11,11,11,11,11,11,11,11,11] // 1 is green boarder, 3 is X, 9 is O, 11 is blank
    var comment             :String = "X moves first."
    var index               :Int = 0
    var isSelected          :Bool = true
    
    init() {
        self.id = UUID()
        self.board = [11,11,11,11,11,11,11,11,11]
        self.comment = "X moves first."
        self.index = 0
        self.isSelected = true
    }
    
    init(id: UUID, board: [Int], comment: String, index: Int, selected: Bool) {
        self.id = id
        self.board = board
        self.comment = comment
        self.index = index
        self.isSelected = selected
    }
    
    init(copyBoard: TicTacToeMove) {
        self.id = UUID()
        self.board = Array(copyBoard.board)
        self.comment = String(copyBoard.comment)
        self.index = Int(copyBoard.index)
        self.isSelected = Bool(copyBoard.isSelected)
    }
}
