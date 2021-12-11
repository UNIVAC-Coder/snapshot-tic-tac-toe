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
private var numberSelected: Int = -1

struct ContentView: View {
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @State private var isBoardView: Bool = true
    @State private var theTicTacToeMove: TicTacToeMove = TicTacToeMove()
    @State private var newDuplicates: [Int] = []
    
    var body: some View {
        GeometryReader { geometry in
            if isBoardView {
                if self.document.games.count > 0 {
                    VStack {
                        Text(messages())
                            .font(.system(size: SquareSide(geometry: geometry) * 0.4))
                            .padding()
                        HStack(spacing: SquareSide(geometry: geometry)) {
                            ForEach (([0,90,180,270]), id: \.self ) { degrees in
                                Text("Rotate \(degrees) degrees")
                                    .frame(width: SquareSide(geometry: geometry) * 3.0, alignment: .center)
                                    .font(.system(size: SquareSide(geometry: geometry) * 0.4))
                            }
                        }
                        HStack {
                            Spacer()
                            ScrollView() {
                                ForEach(self.document.games, id: \.id) { aGame in
                                    if aGame.isSelected {
                                        BoardView(tictactoeMove: aGame, length: SquareSide(geometry: geometry))
                                            .onTapGesture {
                                                theTicTacToeMove = TicTacToeMove(copyBoard: aGame)
                                                isBoardView = false
                                            }
                                            
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }else{
                    Text("Tap here to add first Tic-Tac-Toe game.")
                        .frame(width: 200.0, height: 50.0, alignment: .center)
                        .background(Color("BGColor"))
                        .onTapGesture {
                            self.document.games = [TicTacToeMove()]
                            self.theTicTacToeMove = TicTacToeMove()
                            self.isBoardView = false
                        }
                }
            }else{ // is not isBoardView
                EditView(aTicTacToeMove: $theTicTacToeMove, isBoardView: $isBoardView, document: $document, newDuplicates: $newDuplicates, length: SquareSide(geometry: geometry))
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
            geometryLength = a / 18.0 //there are 16 columns, 5 Rows on this screen
        }
        return geometryLength
    }
    func messages() -> String {
        numberSelected = 0
        for i in document.games.indices {
            if document.games[i].isSelected { numberSelected += 1 }
        }
        if numberSelected == document.games.count { numberSelected = -1 }
        var abc = (numberSelected == -1) ? "All of " : "\(numberSelected) of "
        abc += "\(document.games.count) games selected.  "
        abc += (newDuplicates.count == 0) ? "No Duplicates." : "Duplicates are: " + newDuplicates.description
        return abc
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Snapshot_Tic_Tac_ToeDocument()))
    }
}
*/
