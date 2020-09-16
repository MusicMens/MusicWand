//
//  ScoreModel.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

class ScoreModel: ObservableObject {
    var allTrack = MusicTracks.allTracks
    var allNote = MusicTracks.allNotes
    @Published var notes: Set<Note>
    
    init(inputnotes: [note]) {
        notes = Set<Note>()
        for note in inputnotes {
            let newNote = Note(id: note.noteID, col:note.col, row:note.row, imgName: note.imgName)
            notes.insert(newNote)
        }
    }
    
    
    func noteAt(col: Int, row: Int) -> Note? {
        let note = notes.filter {
            $0.col == col && $0.row == row
        }.first
        return note
    }
    
    func moveNote(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int, imgName: String? = nil) {
        guard let movingNote = noteAt(col: fromCol, row: fromRow) else {return}
        var newNote = Note(id: movingNote.id, col: toCol, row: toRow, imgName: movingNote.imgName)
        // Change local note
        if imgName != nil {
            newNote.imgName = imgName!
        }
        notes.remove(movingNote)
        notes.insert(newNote)
        // Change db note
        let noteToAdd = musicStore.store.findNoteByID(newNote.id)
        musicStore.store.changeNote(noteToAdd!, col: newNote.col, row: newNote.row, imgName: newNote.imgName)
        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())
        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
    }
        
    func addNote(noteToAdd: Note, track: musicTrack){
        let newNote = note()
        newNote.col = noteToAdd.col
        newNote.row = noteToAdd.row
        newNote.noteID = noteToAdd.id
        self.notes.insert(noteToAdd)
        let track = musicStore.store.findTrack(track.title)
        try! musicStore.store.realm.write{
            track!.song.append(newNote)
        }
        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())

    }
    
}
