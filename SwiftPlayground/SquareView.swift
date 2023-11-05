//
//  SquareView.swift
//  Snapshot Tic-Tac-Toe
//  Creative Commons Attribution 4.0 International Public License
//  Creative Commons may be contacted at creativecommons.org.
//
//  Copyright (c) 2021 Thomas Cavalli
//  Thomas Cavalli may be contacted at thomascavalli.com
//
//  List of What Changed (by Who and When):
//  Created by Thomas Cavalli on 11/4/21.
//  Complete reWrite to SwiftUI on IPad using Swift Playgrounds on 11/4/23.
//

import SwiftUI

struct SquareView: View {
   @Binding var games: [TicTacToeMove]
    var gameNumber: Int
    var length: CGFloat
    var index: Int
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var reunrotate = [0,1,2,3,4,5,6,7,8, 2,5,8,1,4,7,0,3,6, 8,7,6,5,4,3,2,1,0, 6,3,0,7,4,1,8,5,2]
    @State var aTicTacToeMove = TicTacToeMove()

    var body: some View {
        Text(xo())
            .frame(width: length, height: length, alignment: .center)
            .foregroundColor(fgColor())
            .background(bgColor())
            .border(.green, width: games[gameNumber].board[index] == 1 ? 5.0 : 0.0)
            .font(.system(size: length * 0.85))
            .onTapGesture {
                if games[gameNumber].board[index] == 11 {
                    aTicTacToeMove = TicTacToeMove(copyBoard: games[gameNumber])
                    for i in aTicTacToeMove.board.indices {
                        if aTicTacToeMove.board[i] == 1 {
                            aTicTacToeMove.board[i] = 11
                        }
                    }
                    aTicTacToeMove.board[reunrotate[index]] = 1
                    rotateBoard()
                    games[gameNumber] = aTicTacToeMove
                    saveGames()
                }
            }
    }
    func xo() -> String {
        var a = " "
        if games[gameNumber].board[index] == 3 { a = "X" }
        if games[gameNumber].board[index] == 9 { a = "O" }
        return a
    }
    func fgColor() -> Color {
        return colorScheme == .dark ? .white : .black
    }
    func bgColor() -> Color {
        return colorScheme == .dark ? .black : .white
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
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func saveGames() {
        let url = getDocumentDirectory().appendingPathComponent("SnapshotTicTacToe.json")
        if let jsonData = try? JSONEncoder().encode(games) {
            do {
                if let json = String(data: jsonData, encoding: .utf8) {
                    try  json.write(to: url, atomically: true, encoding: .utf8)
                }
            }catch{
                
            }
        }
    }
}
