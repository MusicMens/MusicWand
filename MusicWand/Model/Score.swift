////
//  Score.swift
//  MusicWand
//
//  Created by Code Chrysalis on 2020/09/04.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import Foundation
import RealmSwift




class musicTrack: Object {
    @objc dynamic var trackID = UUID().uuidString
    @objc dynamic var title: String = ""
    var song = List<note>()
    
    override static func primaryKey() -> String? {
        return "trackID"
    }
}


class note :Object {
    @objc dynamic var noteID = UUID().uuidString
    @objc dynamic var col: Int = 1
    @objc dynamic var row: Int = 5
    @objc dynamic var imgName: String = "MusicNote"
    
    override static func primaryKey() -> String? {
        return "noteID"
    }

}

struct Note: Hashable {
    var id : String = UUID().uuidString
    var col: Int
    var row: Int
    var imgName: String
}


class musicStore: ObservableObject {
    
    static let store = musicStore()
    let realm = try! Realm()
    
    
    public func addTrack (_ track: musicTrack){
        try!realm.write {
            musicStore.store.realm.add(track)
        }
    }
    
    public func findTrack (_ id : String) -> musicTrack?{
        
        let tracks = musicStore.store.realm.objects(musicTrack.self)
        
        for i in tracks{
            if i.trackID == id {
                return i
            }
        }
        return nil
    }
    

    public func makeTrack (_ title :String ) -> musicTrack {
                let song  = makeToiletSong()
        let newtrack = musicTrack()
        newtrack.title = title
        for oneNote in song {
            newtrack.song.append(oneNote)

        }
        return newtrack
    }
    struct coords {
        var col: Int
        var row: Int
    }
    private func makeToiletSong() -> [note] {
        let notes: [coords] = [ coords(col: 1, row: 6),coords(col: 2, row: 6),coords(col: 3, row: 6),coords(col: 4, row: 6),coords(col: 5, row: 9),coords(col: 6, row: 9),coords(col: 7, row: 8),coords(col: 8, row: 9),coords(col: 9, row: 8),coords(col: 10, row: 6),coords(col: 11, row: 6),coords(col: 12, row: 6),coords(col: 13, row: 8),coords(col: 14, row: 9),coords(col: 14, row: 10),coords(col: 15, row: 6),coords(col: 16, row: 6),coords(col: 17, row: 6),coords(col: 18, row: 6),coords(col: 19, row: 8),coords(col: 20, row: 8), coords(col: 21, row: 9)]
        var result : [note] = []
        for oneNote in notes{
            let newNote = note()
            newNote.col = oneNote.col
            newNote.row = oneNote.row
            result.append(newNote)
        }
        return result
    }
    
    public func deleteTrackByID(_ id: String) {
        
        let tracks = musicStore.store.realm.objects(musicTrack.self)
        for i in tracks {
            try! musicStore.store.realm.write({
                if i.trackID == id{
                    musicStore.store.realm.delete(i)
                }
            })
        }
    }
    
    public func deleteAllTrack (){
        try! musicStore.store.realm.write {
            musicStore.store.realm.deleteAll()
        }
    }
    
    public func findNoteByID(_ id: String) -> note? {
        let notes = musicStore.store.realm.objects(note.self)
        for note in notes {
            if note.noteID == id {
                return note
            }
        }
        return nil
    }
    public func deleteNoteByID(_ id: String) {
        
        let notes = musicStore.store.realm.objects(note.self)
        for i in notes {
            if i.noteID == id{
            try! musicStore.store.realm.write({
                    musicStore.store.realm.delete(i)
                })
            }
        }
    }
    public func changeNote(_ noteToChange: note, col: Int? = nil, row: Int? = nil, imgName: String? = nil) -> Void {
        print(noteToChange)
        try! musicStore.store.realm.write {
            if(col != nil){
                noteToChange.col = col!
            }
            if(row != nil){
                noteToChange.row = row!
            }
            if(imgName != nil){
                noteToChange.imgName = imgName!
            }
        }

    }
}
class MusicTracks {
    public static var allTracks = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
    public static var allNotes = Array(musicStore.store.realm.objects(note.self).freeze())
}
