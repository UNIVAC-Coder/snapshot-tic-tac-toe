//
//  SortView.swift
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
// 1 is green boarder, 3 is X, 9 is O, 11 is blank; 0 is pending.
private var sortX: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0]
private var duplicates: [Int] = []
private var countXs: Int = 0
private var countOs: Int = 0
private var selected: Bool = true
private var anySelected: Bool = true
private var message: String = "The stored games of tic-tac-toe can be sorted using 1 of 24 possible sequences.  Since there are four possible board pieces: the X, the O, blank and green boarder (next move), that gives us 24 possible sequences to sort on.  Choose the piece that you want to appear first, second, third and last from the list below. The sorting will begin when the 'Sort the Games' is clicked.   For example, choose 'X, O, Green, Blank, will sort games with X to appear first in sequence from the top of the game across then second line across and finally third line across. Equal values of X will then sort on O; equal values of O will sort on Green; then Blank lastly.  Also, The number of X's and O's to be displayed can be specified during the sort.  Only those games that match the numbers will be displayed in the scroll view to follow upon completion of the sort.  For example, select 'Three Xs' and 'Any Os' will scroll only games containing exactly three Xs and either two or three Os."

struct SortView: View {
    @Binding var isBoardView: Bool
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @Binding var isEdit: Bool
    @Binding var newDuplicates: [Int]
    var length: CGFloat
    @State private var sortBy: [Int] = [0,0,0,0,0]
    @State private var first: String = ""
    @State private var second: String = ""
    @State private var third: String = ""
    @State private var forth: String = ""
    @State private var numberXs: Int = -1 // any, 0...4
    @State private var numberOs: Int = -1 // any, 0...4
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 5.0) {
                Text("Sort Tic-Tac-Toe games.")
                    .font(.system(size: 30.0))
                    .background(Color("BGColor"))
                    .foregroundColor(Color("DividerColor"))
                Text(message)
                    .font(.system(size: 20.0))
                    .background(Color("BGColor"))
                    .foregroundColor(Color("DividerColor"))
                HStack(spacing: 10.0) {
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
                            sortBy = [0,3,0,0,0]
                            first = "X"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("  O  ") {
                            sortBy = [0,9,0,0,0]
                            first = "O"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("Blank") {
                            sortBy = [0,11,0,0,0]
                            first = "Blank"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Text(first)
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
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
                            sortBy[2] = 3
                            sortBy[3] = 0
                            sortBy[4] = 0
                            second = "X"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "X" || first == "")
                        Button("  O  ") {
                            sortBy[2] = 9
                            sortBy[3] = 0
                            sortBy[4] = 0
                            second = "O"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "O" || first == "")
                        Button("Blank") {
                            sortBy[2] = 11
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
                            sortBy[3] = 3
                            third = "X"
                            forth = FindLast()
                        }
                        .disabled((first == "X" || second == "X") || second == "")
                        Button("  O  ") {
                            sortBy[3] = 9
                            third = "O"
                            forth = FindLast()
                        }
                        .disabled((first == "O" || second == "O") || second == "")
                        Button("Blank") {
                            sortBy[3] = 11
                            third = "Blank"
                            forth = FindLast()
                        }
                        .disabled((first == "Blank" || second == "Blank") || second == "")
                        Text(third)
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
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
                    }
                    VStack {
                        Text("  ")
                    }
                    VStack {
                        Text("Number Xs")
                        Button("Zero Xs") {
                            numberXs = 0
                            numberOs = 0
                        }
                        Button("One X") {
                            numberXs = 1
                            numberOs = -1
                        }
                        Button("Two Xs") {
                            numberXs = 2
                            numberOs = -1
                        }
                        Button("Three Xs") {
                            numberXs = 3
                            numberOs = -1
                        }
                        Button("Four Xs") {
                            numberXs = 4
                            numberOs = -1
                        }
                        /*
                        Button("Any Xs") {
                            numberXs = -1
                            numberOs = -1
                        }
                         */
                        Text(numberXs == -1 ? "# Xs"  : numberXs == 1 ?  "One X" : "\(numberXs) Xs")
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
                    }
                    VStack {
                        Text("Number Os")
                        Button("Zero Os") {
                            numberOs = 0
                        }
                        .disabled(!(numberXs == 0 || numberXs == 1))
                        Button("One O") {
                            numberOs = 1
                        }
                        .disabled(!(numberXs == 1 || numberXs == 2))
                        Button("Two Os") {
                            numberOs = 2
                        }
                        .disabled(!(numberXs == 2 || numberXs == 3))
                        Button("Three Os") {
                            numberOs = 3
                        }
                        .disabled(!(numberXs == 3 || numberXs == 4))
                        Button("Four Os") {
                            numberOs = 4
                        }
                        .disabled(!(numberXs == 4))
                        /*
                        Button("Any Os") {
                            numberOs = -1
                        }
                        .disabled(numberXs <= 1)
                        */
                         Text(numberOs == -1 ? "# Os"  : numberOs == 1 ? "One O" : "\(numberOs) Os")
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
                    }
                }
                HStack {
                    Spacer()
                    Button("Cancel Sort") {
                        isEdit = true
                    }
                    .padding()
                    Button("Sort the games") {
                        anySelected = false
                        SortGames()
                        if anySelected {
                            message = "Finished Sorting"
                            isBoardView = true
                            isEdit = true
                        }else{
                            message = "No games are selected.  Try a lower number of Xs and Os and sort again."
                        }
                    }
                    .padding()
                    .disabled(sortBy[4] == 0 || numberXs < 0 || numberOs < 0)
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    func FindLast() -> String {
        if sortBy[1] != 0 && sortBy[2] != 0 && sortBy[3] != 0 {
            sortBy[4] = 24 - sortBy[1] - sortBy[2] - sortBy[3]
            for i in 1...4 { sortX[sortBy[i]] = i}
            if sortBy[4] == 1 { return "Green" }
            if sortBy[4] == 3 { return "X" }
            if sortBy[4] == 9 { return "O" }
            if sortBy[4] == 11 { return "Blank"}
            // failsafe
            sortBy = [0,1,3,9,11]
            sortX  = [0,1,0,2,0,0,0,0,0,3,0,4]
            first  = "Green"
            second = "X"
            third = "O"
            return "Blank"
        }else{
            return ""
        }
    }
    func SortGames() {
        duplicates.removeAll(keepingCapacity: true)
        newDuplicates.removeAll(keepingCapacity: true)
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
            duplicates.append(secondTTT.index)
            return false
        }
        // finished sorting...
        for i in document.games.indices {
            for j in duplicates.indices {
                if document.games[i].index == duplicates[j] {
                    newDuplicates.append(i)
                    break
                }
            }
            document.games[i].index = i
            selected = true
            if numberXs != -1 {
                countXs = 0
                countOs = 0
                for j in 0...8 {
                    if document.games[i].board[j] == 3 { countXs += 1 }
                    if document.games[i].board[j] == 9 { countOs += 1 }
                }
                if numberXs != countXs {
                    selected = false
                }else{
                    if numberOs != -1 && (numberOs != countOs) {
                        selected = false
                    }
                }
            }
            document.games[i].isSelected = selected
            anySelected = (anySelected || selected)
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
