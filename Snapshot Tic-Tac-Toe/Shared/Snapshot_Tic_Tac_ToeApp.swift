//
//  Snapshot_Tic_Tac_ToeApp.swift
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

@main
struct Snapshot_Tic_Tac_ToeApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Snapshot_Tic_Tac_ToeDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
