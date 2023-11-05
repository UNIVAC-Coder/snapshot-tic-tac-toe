//
//  RowView.swift
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

struct RowView: View {
    @Binding var games: [TicTacToeMove]
    var gameNumber: Int
    var length: CGFloat
    @State var aTicTacToeMove = TicTacToeMove()
    
    let comments: [String] = ["X's Best Move", "X Moves to Win", "X to Block", " X Wins", "O's Best Move", "O Moves to Win", "O to Block", "O Wins", "Draw"]
       
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: length * 16.0, height: 3.0, alignment: .center)
                .background(.primary)
                .padding()
            HStack() {
                Spacer()
                Text("#\(gameNumber)")
                    .foregroundColor(.primary)
                    .font(.largeTitle)
                Spacer()
                Text(games[gameNumber].comment)
                .font(.largeTitle)
                .foregroundColor(.primary)
                .onTapGesture {
                    var i1 = 0
                    aTicTacToeMove = TicTacToeMove(copyBoard: games[gameNumber])
                    for i in comments.indices {
                        if comments[i] == aTicTacToeMove.comment {
                            i1 = i + 1
                            if i1 >= comments.count {
                                i1 = 0
                            }
                        }
                    }
                    aTicTacToeMove.comment = comments[i1]
                    games[gameNumber] = aTicTacToeMove
                    saveGames()
                }
                Spacer()
            }
            HStack {
                Spacer()
                ForEach ([0,9,18,27], id: \.self) { offset in
                    BoardView(games: $games, gameNumber: gameNumber, length: length, offset: offset)
                        .frame(width: length * 4.0, height: length * 3.0, alignment: .center)
                }
                Spacer()
            }
        }
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
