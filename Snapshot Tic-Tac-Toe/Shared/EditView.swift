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
                            generateGames()
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
    func generateGames() { //0 is unused, 1 is green, 3 is X, 9 is O, blank is 11
        message = "Creating"
        aTicTacToeMove.comment = "XO"
        document.games.removeAll(keepingCapacity: true)
        let x = [0,1,3,9,11]
        var s = [0,0,0,0,0,0,0,0] // sums rows, cols then crosses.
        var c = [0,0,0,0,0,0,0,0,0,0,0,0] // counts pieces by indexed value.
        var aok = true
        var counter = -1
        for a0 in 2...4 {
            aTicTacToeMove.board[0] = x[a0]
            for a1 in 2...4 {
                    aTicTacToeMove.board[1] = x[a1]
                    for a2 in 2...4 {
                            aTicTacToeMove.board[2] = x[a2]
                            for a3 in 2...4 {
                                    aTicTacToeMove.board[3] = x[a3]
                                    for a4 in 2...4 {
                                            aTicTacToeMove.board[4] = x[a4]
                                            for a5 in 2...4 {
                                                    aTicTacToeMove.board[5] = x[a5]
                                                    for a6 in 2...4 {
                                                            aTicTacToeMove.board[6] = x[a6]
                                                            for a7 in 2...4 {
                                                                    aTicTacToeMove.board[7] = x[a7]
                                                                    for a8 in 2...4 {
                                                                            aTicTacToeMove.board[8] = x[a8]
                                                                            c = [0,0,0,0,0,0,0,0,0,0,0,0] //green = 1, x = 3, o = 9, blank = 11
                                                                            for i in 0...8 {
                                                                                c[aTicTacToeMove.board[i]] += 1
                                                                            }
                                                                            if  (c[3] == c[9]) || (c[3] == c[9] + 1) {
                                                                                aok = true
                                                                                s[0] = addup(a: 0, b: 1, c: 2)
                                                                                s[1] = addup(a: 3, b: 4, c: 5)
                                                                                s[2] = addup(a: 6, b: 7, c: 8)
                                                                                s[3] = addup(a: 0, b: 3, c: 6)
                                                                                s[4] = addup(a: 1, b: 4, c: 7)
                                                                                s[5] = addup(a: 2, b: 5, c: 8)
                                                                                s[6] = addup(a: 0, b: 4, c: 8)
                                                                                s[7] = addup(a: 2, b: 4, c: 6)
                                                                                for i in 0...7 {
                                                                                    aok = aok && (s[i] != 9) && (s[i] != 27)
                                                                                }
                                                                                if aok {
                                                                                    counter += 1
                                                                                    aTicTacToeMove.index = counter
                                                                                    //if counter < 110 {
                                                                                        document.games.append(TicTacToeMove(copyBoard: aTicTacToeMove))
                                                                                    //}
                                                                                }
                                                                            }
                                                                    } // end for a8
                                                                    
                                                            } // end for a7
                                                            
                                                    } // end for a6
                                                    
                                            } // end for a5
                                            
                                    } // end for a4
                                    
                            } // end for a3
                            
                    } // end for a2
                    
            } // end for a1
            
        } // end for a0
    }
    func addup(a: Int, b: Int, c: Int) -> Int {
        return aTicTacToeMove.board[a] + aTicTacToeMove.board[b] + aTicTacToeMove.board[c]
    }
}
/*
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
*/
