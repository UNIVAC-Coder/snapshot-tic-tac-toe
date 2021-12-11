//
//  Snapshot_Tic_Tac_ToeDocument.swift
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
import UniformTypeIdentifiers

extension UTType {
    static var snapshottictactoe: UTType {
        UTType(importedAs: "com.thomascavalli.snapshottictactoe")
    }
}

struct Snapshot_Tic_Tac_ToeDocument: FileDocument {
    var games: [TicTacToeMove]

    init() {
        self.games = [TicTacToeMove(id: UUID(), board: [11,11,11,11,11,11,11,11,11, 11,11,11,11,11,11,11,11,11, 11,11,11,11,11,11,11,11,11, 11,11,11,11,11,11,11,11,11], comment: "X moves first", index: 0, selected: true) ]
    }

    static var readableContentTypes: [UTType] { [.snapshottictactoe] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.games = try JSONDecoder().decode([TicTacToeMove].self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        if let jsonData = try? JSONEncoder().encode(games) {
            return FileWrapper(regularFileWithContents: jsonData)
        }
        throw CocoaError(.coderInvalidValue)
    }
}
