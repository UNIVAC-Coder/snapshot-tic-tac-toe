//
//  Snapshot_Tic_Tac_ToeApp.swift
//  Shared
//
//  Created by Tom Cavalli on 11/2/21.
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
