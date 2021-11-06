//
//  ContentView.swift
//  Shared
//  Creative Commons Attribution 4.0 International Public License
//  Creative Commons may be contacted at creativecommons.org.
//
//  Copyright (c) 2021 Thomas Cavalli
//  Thomas Cavalli may be contacted at thomascavalli.com
//
//  List of What Changed (by Who and When):
//  Created by Thomas Cavalli on 11/2/21.
//

import SwiftUI

private var geometryWidth:  CGFloat = -1 // is undefined
private var geometryHeight: CGFloat = -1
private var geometryLength: CGFloat = 52 // a reasonable value to start with.

struct ContentView: View {
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @State private var isBoardView: Bool = true
    @State private var theTicTacToeMove: TicTacToeMove = TicTacToeMove()
    
    var body: some View {
        GeometryReader { geometry in
            if isBoardView {
                if self.document.games.count > 0 {
                    HStack {
                        Spacer()
                        ScrollView() {
                            ForEach(self.document.games, id: \.id) { aGame in
                                BoardView(tictactoeMove: aGame, length: SquareSide(geometry: geometry))
                                    .onTapGesture {
                                        theTicTacToeMove = TicTacToeMove(copyBoard: aGame)
                                        isBoardView = false
                                    }
                            }
                        }
                        Spacer()
                    }
                }else{
                    Text("Tap here to add first Tic-Tac-Toe board.")
                        .frame(width: 200.0, height: 50.0, alignment: .center)
                        .background(Color("BGColor"))
                        .onTapGesture {
                            self.document.games = [TicTacToeMove()]
                            self.theTicTacToeMove = TicTacToeMove()
                            self.isBoardView = false
                        }
                }
            }else{ // is not isBoardView
                EditView(aTicTacToeMove: $theTicTacToeMove, isBoardView: $isBoardView, document: $document, length: SquareSide(geometry: geometry))
            }
        }
    }
    
    func SquareSide(geometry: GeometryProxy) -> CGFloat {
        if geometryWidth != geometry.size.width || geometryHeight != geometry.size.height {
            geometryWidth = geometry.size.width
            geometryHeight = geometry.size.height
            var a = geometryWidth
            let b = geometryHeight - (geometryHeight / 9.0)
            if a > b { a = b }
            geometryLength = a / 4.0 //there are 4 columns, 5 Rows on this screen
        }
        return geometryLength
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Snapshot_Tic_Tac_ToeDocument()))
    }
}
*/
