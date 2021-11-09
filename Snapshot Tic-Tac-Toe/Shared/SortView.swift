//
//  SortView.swift
//  Snapshot Tic-Tac-Toe
//
//  Created by Tom Cavalli on 11/9/21.
//

import SwiftUI
// 1 is green boarder, 2 is X, 3 is O, 4 is blank
private var available: [Int] = [0,1,2,3,4]
struct SortView: View {
    @Binding var isBoardView: Bool
    @Binding var document: Snapshot_Tic_Tac_ToeDocument
    @Binding var isEdit: Bool
    @State private var sortBy: [Int] = [0,0,0,0]
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
                            sortBy = [1,0,0,0]
                            first = "Green"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("  X  ") {
                            sortBy = [2,0,0,0]
                            first = "X"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("  O  ") {
                            sortBy = [3,0,0,0]
                            first = "O"
                            second = ""
                            third = ""
                            forth = ""
                        }
                        Button("Blank") {
                            sortBy = [4,0,0,0]
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
                            sortBy[1] = 1
                            sortBy[2] = 0
                            sortBy[3] = 0
                            second = "Green"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "Green")
                        Button("  X  ") {
                            sortBy[1] = 2
                            sortBy[2] = 0
                            sortBy[3] = 0
                            second = "X"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "X")
                        Button("  O  ") {
                            sortBy[1] = 3
                            sortBy[2] = 0
                            sortBy[3] = 0
                            second = "  O  "
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "O")
                        Button("Blank") {
                            sortBy[1] = 4
                            sortBy[2] = 0
                            sortBy[3] = 0
                            second = "Blank"
                            third = ""
                            forth = ""
                        }
                        .disabled(first == "Blank")
                        Text(second)
                            .font(.system(size: 20.0))
                            .background(Color("BGColor"))
                            .foregroundColor(Color("DividerColor"))
                        Spacer()
                    }
                }
                
            }
            Spacer()
        }
        Button("back") {
            isEdit = true
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
