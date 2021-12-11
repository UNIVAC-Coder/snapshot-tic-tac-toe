//
//  SquareView.swift
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

struct SquareView: View {
    var length: CGFloat
    var aBoard: [Int]
    var index: Int
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                ZStack {
                    Text("")
                        .frame(width: length, height: length, alignment: .center)
                        .background(Color(aBoard[index] == 1 ? "Green" : "BGColor"))
                    Text("")
                        .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                        .background(Color("BGColor"))
                    if aBoard[index] == 3 {
                        Text("X")
                            .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                            .foregroundColor(Color("Text"))
                            .background(Color("BGColor"))
                            .font(.system(size: length * 0.85))
                    }
                    if aBoard[index] == 9 {
                        Text("O")
                            .frame(width: length * 0.9, height: length * 0.9, alignment: .center)
                            .foregroundColor(Color("Text"))
                            .background(Color("BGColor"))
                            .font(.system(size: length * 0.85))
                    }
                } // end ZStack
                Text("")
                    .frame(width: length * 0.09, height: length * 1.09, alignment: .leading)
                    .background(Color(sideBar() ? "DividerColor" : "BGColor"))
            }
            Text("")
                .frame(width: length * 1.09, height: length * 0.09, alignment: .top)
                .background(Color(bottomBar() ? "DividerColor" : "BGColor"))
        }
    }
    func sideBar() -> Bool {
        for i in [0,9,18,27] {
            if index == 0 + i { return true }
            if index == 1 + i { return true }
            if index == 3 + i { return true }
            if index == 4 + i { return true }
            if index == 6 + i { return true }
            if index == 7 + i { return true }
        }
        return false
    }
    func bottomBar() -> Bool {
        for i in [0,9,18,27] {
            if index >= 0 + i && index <= 5 + i { return true }
        }
        return false
    }
}
/*
struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView()
    }
}
*/
