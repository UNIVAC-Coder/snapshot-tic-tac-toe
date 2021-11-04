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

struct ContentView: View {
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @State private var tictactoe: String = "empty"
    
    var body: some View {
        VStack {
            ScrollView() {
                ForEach(self.document.games, id: \.self) { aGame in
                    Text(aGame)
                }
            }
            TextField("New game: ", text: $tictactoe, onCommit:  {
                document.games.append(tictactoe)
            })
        }
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Snapshot_Tic_Tac_ToeDocument()))
    }
}
*/
