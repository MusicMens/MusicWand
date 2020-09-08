//
//  ScoreModel.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import Foundation
import Combine

class ScoreModel: ObservableObject {
    @Published var notes: Set<Note> = []
    
    init() {
        notes.insert(Note(col: 1, row: 0, imgName: "MusicNote"))
//        notes.insert(Note(col: 2, row: 14, imgName: "deathknight"))
//        notes.insert(Note(col: 3, row: 7, imgName: "all_classes"))
//        notes.insert(Note(col: 4, row: 5, imgName: "druid"))
        
    }
    
    init(notes: Set<Note> = []) {
        self.notes = notes
    }
    
    func noteAt(col: Int, row: Int) -> Note? {
        notes.filter {
            $0.col == col && $0.row == row
        }.first
    }
    
    func moveNote(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        guard let movingNote = noteAt(col: fromCol, row: fromRow) else {return}
        
        notes.remove(movingNote)
        if let targetNote = noteAt(col: toCol, row: toRow) {
            notes.remove(targetNote)
        }
        
        notes.insert(Note(col: toCol, row: toRow, imgName: movingNote.imgName))
    }
    
    
}
