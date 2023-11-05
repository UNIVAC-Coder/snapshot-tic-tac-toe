//
//  ContentView.swift
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

private var geometryWidth:  CGFloat = 400
private var geometryHeight: CGFloat = 500
private var geometryLength: CGFloat = 52
private var numberSelected: Int = -1

struct ContentView: View {
    @State var games: [TicTacToeMove] =  []
    @State var theView = "start"
    @State var message = ""
    @State var find: [Int] = [11,11,11, 11,11,11, 11,11,11]
    @State var editGame: Int = 0
    @State var validSearch = true
    @State var findCounter = 1
    @State var aTicTacToeMove = TicTacToeMove()
    
    var body: some View {
        GeometryReader() { geometry in
            if theView == "start" {
                VStack  {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("Tap here to load Tic Tac Toe games.") {
                            geometryWidth = geometry.size.width
                            geometryHeight = geometry.size.height
                            var a = geometryWidth
                            let b = geometryHeight - (geometryHeight / 9.0)
                            if a > b { a = b }
                            geometryLength = a / 16.0 //there are 16 columns, 5 Rows on this screen
                            games = getGames(fromBundle: false)
                            if games.count == 0 {
                                games = getGames(fromBundle: true)
                                saveGames()
                            }
                            for i in games.indices {
                                games[i].isSelected = true
                            }
                            theView = "games"
                        }
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        Spacer()
                    }
                    Spacer()
                }
            }
            if theView == "games" {
                if self.games.count >= 0 {
                    VStack {
                        Text(messages())
                            .font(.system(size: geometryLength * 0.4))
                            .padding()
                        HStack(spacing: geometryLength) {
                            ForEach (([0,90,180,270]), id: \.self ) { degrees in
                                Text(degrees == 0 ? "Game 0°" : "Rotate \(degrees)° CCW")
                                    .frame(width: geometryLength * 3.0, alignment: .center)
                                    .font(.system(size: geometryLength * 0.4))
                            }
                        }
                        ScrollView(.vertical) {
                            LazyVStack(alignment: .center) {
                                ForEach(self.games, id: \.id) { aGame in
                                    if aGame.isSelected {
                                        RowView(games: $games, gameNumber: aGame.index, length: geometryLength)
                                            .frame(width: geometryLength * 16.0, height: geometryLength * 5.2, alignment: .center)
                                    }
                                }
                            }
                        }
                        HStack {
                            Button(findCounter == 0 ? "Search or Add" : "Search") {
                                theView = "search"
                            }
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .padding(10)
                            .border(.primary, width: 2)
                            Button("Select All") {
                                for aGame in games {
                                    aGame.isSelected = true
                                }
                                message = "Select "
                              //  theView = "games"
                            }
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .padding(10)
                            .border(.primary, width: 2)
                        }
                    }
                }
            }
            if theView == "search" {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Back") {
                                message = ""
                                theView = "games"
                            }
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .padding(10)
                            .border(.primary, width: 2)
                            .padding(10)
                            if findCounter == 0 && validSearch {
                                Spacer()
                                Button("Add this Game") {
                                    aTicTacToeMove = TicTacToeMove()
                                    for i in 0...8 {
                                        aTicTacToeMove.board[i] = find[i]
                                    }
                                    rotateBoard()
                                    aTicTacToeMove.index = games.count
                                    let b = TicTacToeMove(copyBoard: aTicTacToeMove)
                                    games.append(b)
                                    findCounter = 1
                                    saveGames()
                                }
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .padding(10)
                                .border(.primary, width: 2)
                                .padding(10)
                            }
                            Spacer()
                        }
                        ZStack {
                            VStack {
                                ForEach([0,3,6], id: \.self) { row in
                                    HStack {
                                        ForEach([0,1,2], id: \.self) { col in
                                            Button(bxo(a: find[row + col])) {
                                                switch find[row + col] {
                                                case 3:
                                                    find[row + col] = 9
                                                    break
                                                case 9:
                                                    find[row + col] = 11
                                                    break
                                                case 11:
                                                    find[row + col] = 3
                                                    break
                                                default:
                                                    find[row + col] = 11
                                                    break
                                                }
                                                findCounter = 1
                                                validSearch = true
                                                var X = 0
                                                var O = 0
                                                for found in find {
                                                    if found == 3 { X += 1 }
                                                    if found == 9 { O += 1 }
                                                }
                                                if X != O && X != O + 1 {
                                                    validSearch = false
                                                }
                                            }
                                            .frame(width: geometryLength * 3.0, height: geometryLength * 3.0, alignment: .center)
                                            .font(.system(size: geometryLength * 0.85 * 3.0))
                                            .foregroundColor(.primary)
                                        }
                                    }
                                }
                            }
                            Rectangle() 
                                .frame(width: geometryLength * 9.4, height: 7.0)
                                .offset(x: 0, y: geometryLength * -1.59)
                            Rectangle() 
                                .frame(width: geometryLength * 9.4, height: 7.0)
                                .offset(x: 0, y: geometryLength * 1.59)
                            Rectangle() 
                                .frame(width: 7.0, height: geometryLength * 9.4)
                                .offset(x: geometryLength * -1.59, y: 0.0)
                            Rectangle() 
                                .frame(width: 7.0, height: geometryLength * 9.4)
                                .offset(x: geometryLength * 1.59, y: 0.0)
                            
                            
                        } // end zstack
                        Text(validXO())
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                        if validSearch {
                            Button("Find it") {
                                findIt()
                                theView = "games"
                            }
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .padding(10)
                            .border(.primary, width: 2)
                            .padding(10)
                            .disabled(!validSearch)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        } // end GeometryReader
    }
    func validXO() -> String {
        if validSearch {
            return "Valid Search"
        }else{
            return "Invalid"
        }
    }
    func findIt() {
        var selectIt = false
        findCounter = 0
        for aGame in games {
            for offset in [0,9,18,27] {
                selectIt = true
                for rc in [0,1,2,3,4,5,6,7,8] {
                    if aGame.board[rc + offset] != 1 {
                        if find[rc] != aGame.board[rc + offset] {
                            selectIt = false
                            break
                        }
                    }else{ // == 1
                        if find[rc] != 11 {
                            selectIt = false
                            break
                        }
                    }
                }
                if selectIt {
                    break
                }
            }
            aGame.isSelected = selectIt
            if selectIt { findCounter += 1 }
        }
        message = "Found  "
    }
    func bxo(a: Int) -> String {
        if a == 3 { return "X"}
        if a == 9 { return "O"}
        return " "
    }
    func messages() -> String {
        numberSelected = 0
        for i in games.indices {
            if games[i].isSelected { numberSelected += 1 }
        }
        if numberSelected == games.count { numberSelected = -1 }
        var abc = message
        abc += (numberSelected == -1) ? "All of " : "\(numberSelected) of "
        abc += "\(games.count) games selected.  "
        return abc
    }
    func getGames(fromBundle: Bool) -> [TicTacToeMove] {
        var url: URL
        if fromBundle {
         url = Bundle.main.url(forResource: "SnapshotTicTacToe", withExtension: "json")!
        }else{
          url = getDocumentDirectory().appendingPathComponent("SnapshotTicTacToe.json")
        }
               if let data = try? Data(contentsOf: url) {
            do {
                let someGames = try JSONDecoder().decode([TicTacToeMove].self, from: data)
                return someGames
            }catch{
                
            }
        }
        return []
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
