//
//  ScoreModel.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import Foundation
import Combine

class ScoreGame: ObservableObject {
    @Published var notes: Set<Note> = []
    
    init() {
        notes.insert(Note(col: 0, row: 0, imgName: "MusicNote"))
        notes.insert(Note(col: 0, row: 0, imgName: "deathknight"))
        notes.insert(Note(col: 0, row: 0, imgName: "all_classes"))
        notes.insert(Note(col: 0, row: 0, imgName: "druid"))
        notes.insert(Note(col: 0, row: 0, imgName: "hunter"))
        notes.insert(Note(col: 0, row: 0, imgName: "mage"))
        
    }
    
    init(notes: Set<Note> = []) {
        self.notes = notes
    }
    
    func noteAt(col: Int, row: Int) -> Note? {
        notes.filter {
            $0.col == col && $0.row == row
        }.first
    }
    
    
}
