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
    @Binding var aBoard: TicTacToeMove
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
                        .background(Color(aBoard.board[index] == 1 ? "Green" : "BGColor"))
                    Text("")
                        .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                        .background(Color("BGColor"))
                    if aBoard.board[index] == 3 {
                        Text("X")
                            .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                            .foregroundColor(Color("Text"))
                            .background(Color("BGColor"))
                            .font(.system(size: length * 0.85))
                    }
                    if aBoard.board[index] == 9 {
                        Text("O")
                            .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                            .foregroundColor(Color("Text"))
                            .background(Color("BGColor"))
                            .font(.system(size: length * 0.85))
                    }
                } // end ZStack
                .onTapGesture { // on ZStack
                    message = "Editing"
                    if aBoard.board[index] == 11 { // is blank, tapped, so change to green boarder
                        for i in aBoard.board.indices { // but first, erase any other existing green boarder.
                            if aBoard.board[i] == 1 { aBoard.board[i] = 11}
                        }
                        aBoard.board[index] = 1
                    }else{
                        a = 11
                        if aBoard.board[index] == 1 { a = 3 }
                        if aBoard.board[index] == 3 { a = 9 }
                        if aBoard.board[index] == 11 { a = 1 }
                        aBoard.board[index] = a
                    }
                    DispatchQueue.main.async {
                        notGreen = true
                        var Xs: Int = 0
                        var Os: Int = 0
                        for i in aBoard.board.indices {
                            switch aBoard.board[i] {
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
                    .background(Color(index == 0 || index == 1 || index == 3 || index == 4 || index == 6 || index == 7 ? "DividerColor" : "BGColor"))
            }
            Text("")
                .frame(width: length * 1.09, height: length * 0.09, alignment: .top)
                .background(Color(index < 6 ? "DividerColor" : "BGColor"))
        }
    }
}
/*
struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView()
    }
}
*/
