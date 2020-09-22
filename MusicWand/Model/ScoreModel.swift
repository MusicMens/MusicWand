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
        var rowDiff = 20
        var closestnote: Note?
        let noteSet = notes.filter {
            $0.col == col
        }
        if noteSet.count == 1{
            return noteSet.first
        } else{
            for (_ ,note) in noteSet.enumerated(){
                if abs(row - note.row) < rowDiff{
                    closestnote = note
                    rowDiff = abs(row - note.row)
                }
            }
            return closestnote
            
        }
    }
    
    func noteAtCol(col: Int) -> Set<Note>{
        return notes.filter {
            $0.col == col
        }
    }
    func noteByID(id:String) -> Note?{
        let noteSet = notes.filter {
            $0.id == id
        }
        return noteSet.first
    }
    
    func moveNote(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int, imgName: String? = nil) {
        guard let movingNote = noteAt(col: fromCol, row: fromRow) else {return}
        var highlightedNote = false
        var newNote = Note(id: movingNote.id, col: toCol, row: toRow, imgName: movingNote.imgName)
        // Change local note
        if imgName != nil {
            newNote.imgName = imgName!
        }
        if movingNote.imgName.last == "H" {
            highlightedNote = true
            newNote.imgName = String(movingNote.imgName.dropLast())

        }
        notes.remove(movingNote)
        // Change db note
        let noteToAdd = musicStore.store.findNoteByID(newNote.id)
        musicStore.store.changeNote(noteToAdd!, col: newNote.col, row: newNote.row, imgName: newNote.imgName)
        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())
        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
        if highlightedNote == true{
            newNote.imgName += "H"
        }
        notes.insert(newNote)

    }
    func moveNoteByID(id: String, toCol: Int, toRow: Int, imgName: String? = nil) {
        guard let movingNote = noteByID(id: id) else {return}
        var highlightedNote = false
        var newNote = Note(id: movingNote.id, col: toCol, row: toRow, imgName: movingNote.imgName)
        // Change local note
        if imgName != nil {
            newNote.imgName = imgName!
        }
        if movingNote.imgName.last == "H" {
            highlightedNote = true
            newNote.imgName = String(movingNote.imgName.dropLast())

        }
        if newNote.row < 0 {
            newNote.row = 0
           }
        if newNote.row > 18 {
            newNote.row = 18
           }
        if newNote.col < 1{
            newNote.col = 1
           }
        notes.remove(movingNote)
        // Change db note
        let noteToAdd = musicStore.store.findNoteByID(newNote.id)
        musicStore.store.changeNote(noteToAdd!, col: newNote.col, row: newNote.row, imgName: newNote.imgName)
        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())
        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
        if highlightedNote == true{
            newNote.imgName += "H"
        }
        
        notes.insert(newNote)

    }
    
    func highlightNote(note: Note){
        print ("highlight" , note.imgName)
        let noteToChange = Note(id: note.id, col: note.col, row: note.row, imgName: note.imgName + "H")
        notes.remove(note)
        notes.insert(noteToChange)
    }
    
    func unhighlightNote(note:Note){
        print("Unhighlight", note.imgName)
        let noteString = String(note.imgName.dropLast())
        print(noteString)
        let noteToChange = Note(id: note.id, col: note.col, row: note.row, imgName: noteString )
        notes.remove(note)
        notes.insert(noteToChange)

    }
    func lastCol() -> Int{
        var lastCol = 0
        for item in notes {
            if item.col > lastCol {
                lastCol = item.col
            }
        }
        return lastCol + 1
    }
    
    func addNote(track: musicTrack) -> Note {
        let noteToAdd = Note(col: lastCol(), row: 5, imgName: "MusicNote")
        let newNote = note()
        newNote.col = lastCol()
        newNote.row = noteToAdd.row
        newNote.noteID = noteToAdd.id
        self.notes.insert(noteToAdd)
        let track = musicStore.store.findTrack(track.trackID)
        try! musicStore.store.realm.write{
            track!.song.append(newNote)
        }
        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())
        return noteToAdd
    }
    func deleteNote(deleteNote: Note){

         self.notes.remove(deleteNote)
        musicStore.store.deleteNoteByID(deleteNote.id)
         self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
         self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())

     }
     
    func clearNotes(){
        for note in notes{
            musicStore.store.deleteNoteByID(note.id)
            notes.remove(note)
        }
        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())
    }
    func highlightNotes(col: Int){
        let notes: Set<Note> = noteAtCol(col: col)
        for note in notes{
            highlightNote(note: note)
        }
        
    }
    func unhighlightNotes(col:Int){
        let notes: Set<Note> = noteAtCol(col: col)
        for note in notes{
            unhighlightNote(note: note)
        }

    }

}
