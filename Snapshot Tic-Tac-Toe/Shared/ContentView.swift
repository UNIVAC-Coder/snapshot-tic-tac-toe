//
//  ContentView.swift
//  Shared
//
//  Created by Tom Cavalli on 11/2/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: Snapshot_Tic_Tac_ToeDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Snapshot_Tic_Tac_ToeDocument()))
    }
}
