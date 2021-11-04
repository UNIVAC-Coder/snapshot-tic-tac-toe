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
    var games: [String]

    init(text: [String] = ["X        >XO       "]) {
        self.games = text
    }

    static var readableContentTypes: [UTType] { [.snapshottictactoe] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let parse = try NSKeyedUnarchiver(forReadingFrom: data)
        parse.requiresSecureCoding = true
        self.games = parse.decodeDecodable([String].self, forKey: "T") ?? ["         >         "]
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let abc = NSKeyedArchiver(requiringSecureCoding: true)
        try abc.encodeEncodable(self.games, forKey: "T")
        abc.finishEncoding()
        return FileWrapper(regularFileWithContents: abc.encodedData)
    }
}
