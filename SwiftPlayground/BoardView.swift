//
//  BoardView.swift
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

struct BoardView: View {
    @Binding var games: [TicTacToeMove]
    var gameNumber: Int
    var length: CGFloat
    var offset: Int
    
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                ForEach([0,3,6], id: \.self) { row in
                    HStack(spacing: 0.0) {
                        ForEach((0...2), id: \.self) { col in
                            SquareView(games: $games, gameNumber: gameNumber, length: length, index: row + col + offset)
                                .frame(width: length, height: length, alignment: .center)
                        }
                    }
                }
            } // end vstack
            Rectangle()
                .frame(width: 3.5, height: length * 3.0)
                .background(.primary)
                .offset(x: length * -0.5, y: 0.0)
            Rectangle()
                .frame(width: 3.5, height: length * 3.0)
                .background(.primary)
                .offset(x: length * 0.5, y: 0.0)
            Rectangle()
                .frame(width: length * 3.0, height: 3.5)
                .background(.primary)
                .offset(x: 0.0, y: length * -0.5)
            Rectangle()
                .frame(width: length * 3.0, height: 3.5)
                .background(.primary)
                .offset(x: 0.0, y: length * 0.5)
        }
        .frame(width: length * 4.0, height: length * 3.0)
    }
}
