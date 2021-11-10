//
//  SortView.swift
//  Snapshot Tic-Tac-Toe
//
//  Created by Tom Cavalli on 11/9/21.
//

import SwiftUI
// 1 is green boarder, 2 is X, 3 is O, 4 is blank
private var sortX: [Int] = [0,0,0,0,0]

struct SortView: View {
    @Binding var isBoardView: Bool
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @Binding var isEdit: Bool
    @State private var sortBy: [Int] = [0,0,0,0,0]
    @State private var first: String = ""
    @State private var second: String = ""
    @State private var third: String = ""
    @State private var forth: String = ""
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Sort Tic-Tac-Toe games.")
                    .font(.system(size: 30.0))
                    .background(Color("BGColor"))
                    .foregroundColor(Color("DividerColor"))
                Text("The stored games of tic-tac-toe can be sorted using 1 of 16 possible sequences.  Since there are four possible board pieces: the X, the O, blank and green boarder (next move), that gives us 16 possible sequences to sort.  Choose the pieces that you want to appear first, second, third and last from the list below. The sorting will begin immediately   For example, choose 'X, O, Green, Blank, will sort games with X to appear first in sequence from the top of the game across then second line across and finally third line across. Equal values of X will then sort on O; equal values of O will sort on Green; then Blank lastly.")
                    .font(.system(size: 20.0))
                    .background(Color("BGColor"))
                    .foregroundColor(Color("DividerColor"))
                HStack {
                    VStack {
                        Text("First")
                        Button("Green") {
                            sortBy = [0,1,0,0,0]
                            first = "Green"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("  X  ") {
                            sortBy = [0,2,0,0,0]
                            first = "X"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("  O  ") {
                            sortBy = [0,3,0,0,0]
                            first = "O"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("Blank") {
                            sortBy = [0,4,0,0,0]
                            first = "Blank"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Text(first)
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
                        Spacer()
                    }
                    VStack {
                        Text("Second")
                        Button("Green") {
                            sortBy[2] = 1
                            sortBy[4] = 0
                            sortBy[4] = 0
                            second = "Green"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "Green" || first == "")
                        Button("  X  ") {
                            sortBy[2] = 2
                            sortBy[3] = 0
                            sortBy[4] = 0
                            second = "X"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "X" || first == "")
                        Button("  O  ") {
                            sortBy[2] = 3
                            sortBy[3] = 0
                            sortBy[4] = 0
                            second = "O"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "O" || first == "")
                        Button("Blank") {
                            sortBy[2] = 4
                            sortBy[3] = 0
                            sortBy[4] = 0
                            second = "Blank"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "Blank" || first == "")
                        Text(second)
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
                        Spacer()
                    }
                    VStack {
                        Text("Third")
                        Button("Green") {
                            sortBy[3] = 1
                            third = "Green"
                            forth = FindLast()
                        }
                        .disabled((first == "Green" || second == "Green") || second == "")
                        Button("  X  ") {
                            sortBy[3] = 2
                            third = "X"
                            forth = FindLast()
                        }
                        .disabled((first == "X" || second == "X") || second == "")
                        Button("  O  ") {
                            sortBy[3] = 3
                            third = "O"
                            forth = FindLast()
                        }
                        .disabled((first == "O" || second == "O") || second == "")
                        Button("Blank") {
                            sortBy[3] = 4
                            third = "Blank"
                            forth = FindLast()
                        }
                        .disabled((first == "Blank" || second == "Blank") || second == "")
                        Text(third)
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
                        Spacer()
                    }
                    VStack {
                        Text("Fourth")
                        Button("Green") { }
                            .disabled(true)
                        Button("  X  ") { }
                            .disabled(true)
                        Button("  O  ") { }
                            .disabled(true)
                        Button("Blank") { }
                            .disabled(true)
                        Text(forth)
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
                        Spacer()
                    }
                }
                HStack {
                    Spacer()
                    Button("Cancel Sort") {
                        isEdit = true
                    }
                    .padding()
                    Button("Sort the games") {
                        SortGames()
                        isBoardView = true
                    }
                    .padding()
                    .disabled(sortBy[4] == 0)
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }
        Button("Back") {
            isEdit = true
        }
    }
    func FindLast() -> String {
        if sortBy[1] != 0 && sortBy[2] != 0 && sortBy[3] != 0 {
            sortBy[4] = 10 - sortBy[1] - sortBy[2] - sortBy[3]
            for i in 1...4 { sortX[sortBy[i]] = i}
            if sortBy[4] == 1 { return "Green" }
            if sortBy[4] == 2 { return "X" }
            if sortBy[4] == 3 { return "O" }
            if sortBy[4] == 4 { return "Blank"}
            sortBy = [0,1,2,3,4]
            sortX  = [0,1,2,3,4]
            first  = "Green"
            second = "X"
            third = "O"
            return "Blank"
        }else{
            return ""
        }
    }
    func SortGames() {
        document.games.sort { firstTTT, secondTTT in
            for i in 0...8 {
                if sortX[firstTTT.board[i]] < sortX[secondTTT.board[i]] {
                    return true
                }else{
                    if sortX[firstTTT.board[i]] > sortX[secondTTT.board[i]] {
                        return false
                    }
                }
            }
            return false
        }
        for i in document.games.indices {
            document.games[i].index = Int(i)
        }
    }
}
/*
struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}
*/
