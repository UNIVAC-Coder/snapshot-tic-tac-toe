//
//  EditView.swift
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

import SwiftUI

struct EditView: View {
    @Binding var aTicTacToeMove: TicTacToeMove
    @Binding var isBoardView: Bool
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @Binding var newDuplicates: [Int]
    var length: CGFloat
    @State private var message: String = "Editing"
    @State private var notGreen: Bool = true
    @State private var isEdit: Bool = true // sorting when false.
    
    var body: some View {
        if isEdit {
            HStack {
                Spacer()
                VStack {
                    Text(message + " #\(aTicTacToeMove.index)")
                        .frame(width: length * 4.0, height: length * 0.2, alignment: .center)
                        .foregroundColor(Color("DividerColor"))
                        .font(.system(size: length * 0.2))
                    TextEditor(text: $aTicTacToeMove.comment)
                        .frame(width: length * 3.3, height: length * 0.3, alignment: .center)
                        .font(.system(size: length * 0.2))
                        .foregroundColor(Color("DividerColor"))
                        .background(Color("BGColor"))
                        .multilineTextAlignment(.center)
                    VStack(spacing: 0.0) {
                        ForEach([0,3,6], id: \.self) { row in
                            HStack(spacing: 0.0) {
                                ForEach((0...2), id: \.self) { col in
                                    SquareViewEdit(length: length, aBoard: $aTicTacToeMove, index: row + col, notGreen: $notGreen, document: $document)
                                }
                            }
                        }
                    }
                    HStack {
                        Button("Save Board") {
                            message = "Saved"
                            if aTicTacToeMove.index == document.games.count {
                                document.games.append(TicTacToeMove(copyBoard: aTicTacToeMove))
                            }else{
                                document.games[aTicTacToeMove.index] = aTicTacToeMove
                            }
                            for i in document.games.indices {
                                document.games[i].index = Int(i)
                            }
                        }
                        .disabled(notGreen)
                        Button("Copy Board") {
                            message = "Copied"
                            aTicTacToeMove.index = Int(document.games.count)
                        }
                        Button("End Editing") {
                            isBoardView = true
                        }
                        Button("Cancel Changes") {
                            isBoardView = true
                        }
                    }
                    HStack {
                        Button("Sort the Games") {
                            isEdit = false
                        }
                        Button("Create all possible game combinations") {
                            var notDone = true
                            var counter = 0
                            var greenBoarderFound = -1
                            
                            while notDone {
                                //find and move green boarder:
                                greenBoarderFound = -1
                                for i in 0...8 {
                                    if greenBoarderFound > -1 {
                                        if aTicTacToeMove.board[i] == 4 {
                                            aTicTacToeMove.board[greenBoarderFound] = 4
                                            aTicTacToeMove.board[i] = 1
                                            greenBoarderFound = i
                                            appendGame()
                                        }
                                        
                                    }else{
                                        if aTicTacToeMove.board[i] == 4 {
                                            greenBoarderFound = i
                                            aTicTacToeMove.board[i] = 1
                                            appendGame()
                                        }
                                        if aTicTacToeMove.board[i] == 1 {
                                            greenBoarderFound = i
                                        }
                                    }
                                }
                                //create next X and O game.
                                
                            }
                            
                        }
                        .disabled(document.games.count > 1)
                    }
                    
                }
                Spacer()
            }
        }else{ // false isEdit
            SortView(isBoardView: $isBoardView, document: $document, isEdit: $isEdit, newDuplicates: $newDuplicates, length: length)
        }
    }
    func appendGame() {
        
    }
}
/*
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
*/
