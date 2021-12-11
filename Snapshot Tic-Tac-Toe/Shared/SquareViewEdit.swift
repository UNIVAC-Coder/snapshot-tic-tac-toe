//
//  SquareViewEdit.swift
//  Snapshot Tic-Tac-Toe
//  Creative Commons Attribution 4.0 International Public License
//  Creative Commons may be contacted at creativecommons.org.
//
//  Copyright (c) 2021 Thomas Cavalli
//  Thomas Cavalli may be contacted at thomascavalli.com
//
//  List of What Changed (by Who and When):
//  Created by Thomas Cavalli on 11/6/21.
//

import SwiftUI

var a = 11
struct SquareViewEdit: View {
    var length: CGFloat
    @Binding var aTicTacToeMove: TicTacToeMove
    var index: Int
    @Binding var notGreen: Bool
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @Binding var message: String
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                ZStack {
                    Text("")
                        .frame(width: length, height: length, alignment: .center)
                        .background(Color(aTicTacToeMove.board[index] == 1 ? "Green" : "BGColor"))
                    Text("")
                        .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                        .background(Color("BGColor"))
                    if aTicTacToeMove.board[index] == 3 {
                        Text("X")
                            .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                            .foregroundColor(Color("Text"))
                            .background(Color("BGColor"))
                            .font(.system(size: length * 0.85))
                    }
                    if aTicTacToeMove.board[index] == 9 {
                        Text("O")
                            .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                            .foregroundColor(Color("Text"))
                            .background(Color("BGColor"))
                            .font(.system(size: length * 0.85))
                    }
                } // end ZStack
                .onTapGesture { // on ZStack
                    message = "Editing"
                    if aTicTacToeMove.board[index] == 11 { // is blank, tapped, so change to green boarder
                        for i in aTicTacToeMove.board.indices { // but first, erase any other existing green boarder.
                            if aTicTacToeMove.board[i] == 1 { aTicTacToeMove.board[i] = 11}
                        }
                        aTicTacToeMove.board[index] = 1
                    }else{
                        a = 11
                        if aTicTacToeMove.board[index] == 1 { a = 3 }
                        if aTicTacToeMove.board[index] == 3 { a = 9 }
                        if aTicTacToeMove.board[index] == 11 { a = 1 }
                        aTicTacToeMove.board[index] = a
                    }
                    aTicTacToeMove.board[index % 9] = aTicTacToeMove.board[index] //cool but need to unrotate first.
                    rotateBoard()
                    
                    DispatchQueue.main.async {
                        
                        notGreen = true
                        var Xs: Int = 0
                        var Os: Int = 0
                        for i in aTicTacToeMove.board.indices {
                            switch aTicTacToeMove.board[i] {
                            case 1:
                                notGreen = false
                                break
                            case 3:
                                Xs += 1
                                break
                            case 9:
                                Os += 1
                                break
                            default:
                                break
                            }
                        }
                        if (Os + 1) == Xs || Os == Xs {
                            notGreen = false
                        }else{
                            notGreen = true
                        }
                        document.games[0] = document.games[0]
                    }
                }
                Text("")
                    .frame(width: length * 0.09, height: length * 1.09, alignment: .leading)
                    .background(Color(sideBar() ? "DividerColor" : "BGColor"))
            }
            Text("")
                .frame(width: length * 1.09, height: length * 0.09, alignment: .top)
                .background(Color(bottomBar() ? "DividerColor" : "BGColor"))
        }
    }
    func sideBar() -> Bool {
        for i in [0,9,18,27] {
            if index == 0 + i { return true }
            if index == 1 + i { return true }
            if index == 3 + i { return true }
            if index == 4 + i { return true }
            if index == 6 + i { return true }
            if index == 7 + i { return true }
        }
        return false
    }
    func bottomBar() -> Bool {
        for i in [0,9,18,27] {
            if index >= 0 + i && index <= 5 + i { return true }
        }
        return false
    }
    func rotateBoard() {
        aTicTacToeMove.board[15]  = aTicTacToeMove.board[0] // 9+6
        aTicTacToeMove.board[26]  = aTicTacToeMove.board[0] //18+8
        aTicTacToeMove.board[29]  = aTicTacToeMove.board[0] //27+2
        
        aTicTacToeMove.board[12]  = aTicTacToeMove.board[1] // 9+3
        aTicTacToeMove.board[25]  = aTicTacToeMove.board[1] //18+7
        aTicTacToeMove.board[32]  = aTicTacToeMove.board[1] //27+5
        
        aTicTacToeMove.board[09]  = aTicTacToeMove.board[2] // 9+0
        aTicTacToeMove.board[24]  = aTicTacToeMove.board[2] //18+6
        aTicTacToeMove.board[35]  = aTicTacToeMove.board[2] //27+8
        
        aTicTacToeMove.board[16]  = aTicTacToeMove.board[3] // 9+7
        aTicTacToeMove.board[23]  = aTicTacToeMove.board[3] //18+5
        aTicTacToeMove.board[28]  = aTicTacToeMove.board[3] //27+1
        
        aTicTacToeMove.board[13]  = aTicTacToeMove.board[4] // 9+4
        aTicTacToeMove.board[22]  = aTicTacToeMove.board[4] //18+4
        aTicTacToeMove.board[31]  = aTicTacToeMove.board[4] //27+4
        
        aTicTacToeMove.board[10]  = aTicTacToeMove.board[5] // 9+1
        aTicTacToeMove.board[21]  = aTicTacToeMove.board[5] //18+3
        aTicTacToeMove.board[34]  = aTicTacToeMove.board[5] //27+7
        
        aTicTacToeMove.board[17]  = aTicTacToeMove.board[6] // 9+8
        aTicTacToeMove.board[20]  = aTicTacToeMove.board[6] //18+2
        aTicTacToeMove.board[27]  = aTicTacToeMove.board[6] //27+0
        
        aTicTacToeMove.board[14]  = aTicTacToeMove.board[7] // 9+5
        aTicTacToeMove.board[19]  = aTicTacToeMove.board[7] //18+1
        aTicTacToeMove.board[30]  = aTicTacToeMove.board[7] //27+3
        
        aTicTacToeMove.board[11]  = aTicTacToeMove.board[8] // 9+2
        aTicTacToeMove.board[18]  = aTicTacToeMove.board[8] //18+0
        aTicTacToeMove.board[33]  = aTicTacToeMove.board[8] //27+6
    }
}
/*
struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView()
    }
}
*/
