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
                                    SquareViewEdit(length: length, aBoard: $aTicTacToeMove, index: row + col, notGreen: $notGreen, document: $document, message: $message)
                                }
                            }
                        }
                    }
                    HStack {
                        Button("Save Board") {
                            message = "All ready Saved"
                            var aok = true
                            rotateBoard()
                            for i in document.games.indices {
                                document.games[i].index = Int(i)
                                if document.games[i].board == aTicTacToeMove.board {
                                    aok = false
                                }
                                if document.games[i].board90 == aTicTacToeMove.board {
                                    aok = false
                                }
                                if document.games[i].board180 == aTicTacToeMove.board {
                                    aok = false
                                }
                                if document.games[i].board270 == aTicTacToeMove.board {
                                    aok = false
                                }
                            }
                            if aok {
                                message = "Saved"
                                if aTicTacToeMove.index == document.games.count {
                                    document.games.append(TicTacToeMove(copyBoard: aTicTacToeMove))
                                }else{
                                    document.games[aTicTacToeMove.index] = aTicTacToeMove
                                }
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
                        Button("Sort the Games") {
                            isEdit = false
                        }
                    }
                    HStack {
                        Spacer()
                        Button("Create all possible game combinations with green boarder, 5190 games, 11 minutes.") {
                            generateGames(a: 1)
                        }
                        .disabled(document.games.count > 1)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Create all possible game combinations without a green boarder, 1142 games, 2 minutes.") {
                            generateGames(a: 2)
                        }
                        .disabled(document.games.count > 1)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Search for matching game.") {
                            SearchFor()
                        }
                        .disabled(notGreen)
                        Spacer()
                    }
                    
                }
                Spacer()
            }
        }else{ // false isEdit
            SortView(isBoardView: $isBoardView, document: $document, isEdit: $isEdit, newDuplicates: $newDuplicates, length: length)
        }
    }
    func SearchFor() {
        message = "Game Not Found"
        for aGame in document.games {
            switch aTicTacToeMove.board {
            case aGame.board, aGame.board90, aGame.board180, aGame.board270 :
                message = "Game Found"
                aTicTacToeMove = TicTacToeMove(copyBoard: aGame)
                break
            default:
                break
            }
        }
    }
    func generateGames(a: Int) {
        message = "Creating"
        aTicTacToeMove.comment = "XO"
        document.games.removeAll(keepingCapacity: true)
        let x = [0,1,3,9,11]  // 0 is unused, 1 is green, 3 is X, 9 is O, blank is 11
        var s = [0,0,0,0,0,0,0,0] // sums rows, cols then crosses.
        var c = [0,0,0,0,0,0,0,0,0,0,0,0] // counts pieces by indexed value, x[ ].
        var aok = true
        var counter = -1
        var g0 = 0
        var g1 = 0
        var g2 = 0
        var g3 = 0
        var g4 = 0
        var g5 = 0
        var g6 = 0
        var g7 = 0
        var g8 = 0
        for a0 in a...4 {
            g0 = (a0 == 1) ? 1 : 0
            aTicTacToeMove.board[0] = x[a0]
            for a1 in a...4 {
                g1 = (a1 == 1) ? 1 : 0
                if g0 + g1 <= 1 {
                    aTicTacToeMove.board[1] = x[a1]
                    for a2 in a...4 {
                        g2 = (a2 == 1) ? 1 : 0
                        if g0 + g1 + g2 <= 1 {
                            aTicTacToeMove.board[2] = x[a2]
                            for a3 in a...4 {
                                g3 = (a3 == 1) ? 1 : 0
                                if g0 + g1 + g2 + g3 <= 1 {
                                    aTicTacToeMove.board[3] = x[a3]
                                    for a4 in a...4 {
                                        g4 = (a4 == 1) ? 1 : 0
                                        if g0 + g1 + g2 + g3 + g4 <= 1 {
                                            aTicTacToeMove.board[4] = x[a4]
                                            for a5 in a...4 {
                                                g5 = (a5 == 1) ? 1 : 0
                                                if g0 + g1 + g2 + g3 + g4 + g5 <= 1 {
                                                    aTicTacToeMove.board[5] = x[a5]
                                                    for a6 in a...4 {
                                                        g6 = (a6 == 1) ? 1 : 0
                                                        if g0 + g1 + g2 + g3 + g4 + g5 + g6 <= 1 {
                                                            aTicTacToeMove.board[6] = x[a6]
                                                            for a7 in a...4 {
                                                                g7 = (a7 == 1) ? 1 : 0
                                                                if g0 + g1 + g2 + g3 + g4 + g5 + g6 + g7 <= 1 {
                                                                    aTicTacToeMove.board[7] = x[a7]
                                                                    for a8 in a...4 {
                                                                        g8 = (a8 == 1) ? 1 : 0
                                                                        if g0 + g1 + g2 + g3 + g4 + g5 + g6 + g7 + g8 <= 1 {
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
                                                                                    /* an idea...
                                                                                    for i in 0...7 {
                                                                                        if (c[3] == c[9]) {
                                                                                            aok = aok && (s[i] == 17)
                                                                                        }
                                                                                        if (c[3] == c[9] + 1) {
                                                                                            
                                                                                        }
                                                                                    } */
                                                                                    for i in document.games.indices {
                                                                                        if document.games[i].board == aTicTacToeMove.board {
                                                                                            aok = false
                                                                                            break
                                                                                        }
                                                                                        if document.games[i].board90 == aTicTacToeMove.board {
                                                                                            aok = false
                                                                                            break
                                                                                        }
                                                                                        if document.games[i].board180 == aTicTacToeMove.board {
                                                                                            aok = false
                                                                                            break
                                                                                        }
                                                                                        if document.games[i].board270 == aTicTacToeMove.board {
                                                                                            aok = false
                                                                                            break
                                                                                        }
                                                                                        // rotate 90 degrees 3 times and check for symmetry.
                                                                                    }
                                                                                    if aok {
                                                                                        counter += 1
                                                                                        aTicTacToeMove.index = counter
                                                                                        //if counter < 110 {
                                                                                            rotateBoard()
                                                                                            document.games.append(TicTacToeMove(copyBoard: aTicTacToeMove))
                                                                                        //}
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    } // end for a8
                                                                }
                                                            } // end for a7
                                                        }
                                                    } // end for a6
                                                }
                                            } // end for a5
                                        }
                                    } // end for a4
                                }
                            } // end for a3
                        }
                    } // end for a2
                }
            } // end for a1
            
        } // end for a0
    }
    func addup(a: Int, b: Int, c: Int) -> Int {
        return aTicTacToeMove.board[a] + aTicTacToeMove.board[b] + aTicTacToeMove.board[c]
    }
    func rotateBoard() {
        aTicTacToeMove.board90[6]   = aTicTacToeMove.board[0]
        aTicTacToeMove.board180[8]  = aTicTacToeMove.board[0]
        aTicTacToeMove.board270[2]  = aTicTacToeMove.board[0]
        
        aTicTacToeMove.board90[3]   = aTicTacToeMove.board[1]
        aTicTacToeMove.board180[7]  = aTicTacToeMove.board[1]
        aTicTacToeMove.board270[5]  = aTicTacToeMove.board[1]
        
        aTicTacToeMove.board90[0]   = aTicTacToeMove.board[2]
        aTicTacToeMove.board180[6]  = aTicTacToeMove.board[2]
        aTicTacToeMove.board270[8]  = aTicTacToeMove.board[2]
        
        aTicTacToeMove.board90[7]   = aTicTacToeMove.board[3]
        aTicTacToeMove.board180[5]  = aTicTacToeMove.board[3]
        aTicTacToeMove.board270[1]  = aTicTacToeMove.board[3]
        
        aTicTacToeMove.board90[4]   = aTicTacToeMove.board[4]
        aTicTacToeMove.board180[4]  = aTicTacToeMove.board[4]
        aTicTacToeMove.board270[4]  = aTicTacToeMove.board[4]
        
        aTicTacToeMove.board90[1]   = aTicTacToeMove.board[5]
        aTicTacToeMove.board180[3]  = aTicTacToeMove.board[5]
        aTicTacToeMove.board270[7]  = aTicTacToeMove.board[5]
        
        aTicTacToeMove.board90[8]   = aTicTacToeMove.board[6]
        aTicTacToeMove.board180[2]  = aTicTacToeMove.board[6]
        aTicTacToeMove.board270[0]  = aTicTacToeMove.board[6]
        
        aTicTacToeMove.board90[5]   = aTicTacToeMove.board[7]
        aTicTacToeMove.board180[1]  = aTicTacToeMove.board[7]
        aTicTacToeMove.board270[3]  = aTicTacToeMove.board[7]
        
        aTicTacToeMove.board90[2]   = aTicTacToeMove.board[8]
        aTicTacToeMove.board180[0]  = aTicTacToeMove.board[8]
        aTicTacToeMove.board270[6]  = aTicTacToeMove.board[8]
    }
}
/*
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
*/
