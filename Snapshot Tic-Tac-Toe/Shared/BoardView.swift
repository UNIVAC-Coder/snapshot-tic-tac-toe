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
//

import SwiftUI

struct BoardView: View {
    var tictactoeMove: TicTacToeMove
    var length: CGFloat
    
    var body: some View {
        //HStack {
            //Spacer()
            VStack {
                Text("")
                    .frame(width: length * 4.0, height: 3.0, alignment: .center)
                    .background(Color("DividerColor"))
                    .padding()
                Text("#\(tictactoeMove.index)")
                    .frame(width: length * 4.0, height: length * 0.2, alignment: .center)
                    .foregroundColor(Color("DividerColor"))
                    .font(.system(size: length * 0.2))
                Text(tictactoeMove.comment)
                    .frame(width: length * 3.3, height: length * 0.3, alignment: .center)
                    .font(.system(size: length * 0.2))
                VStack(spacing: 0.0) {
                    ForEach([0,3,6], id: \.self) { row in
                        HStack(spacing: 0.0) {
                            ForEach((0...2), id: \.self) { col in
                                SquareView(length: length, aBoard: tictactoeMove.board, index: row + col)
                            }
                        }
                    }
                }
            }
            //Spacer()
       // }
    }
}
/*
struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
*/
