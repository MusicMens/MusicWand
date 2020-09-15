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
    @objc dynamic var col: Int = 1
    @objc dynamic var row: Int = 5
    @objc dynamic var imgName: String = "MusicNote"
}

class musicStore: ObservableObject {
    
    static let store = musicStore()
    let realm = try! Realm()
    
    
    public func addTrack (_ track: musicTrack){
        try!realm.write {
            musicStore.store.realm.add(track)
        }
    }
    
    public func findTrack (_ title : String) -> musicTrack?{
        
        let tracks = musicStore.store.realm.objects(musicTrack.self)
        
        for i in tracks{
            if i.title == title {
                return i
            }
        }
        return nil
    }
    
    public func findAllTracks () -> Results<musicTrack>{
        let tracks = musicStore.store.realm.objects(musicTrack.self)
        return tracks
    }
    
    public func makeTrack (_ title :String ) -> musicTrack {
                let song  = note()
        let newtrack = musicTrack()
        newtrack.title = title
               newtrack.song.append(song)
        return newtrack
    }
    
    public func deleteTrackByName(_ title: String) {
        
        let tracks = musicStore.store.realm.objects(musicTrack.self)
        for i in tracks {
            try! musicStore.store.realm.write({
                if i.title == title{
                    musicStore.store.realm.delete(i)
                    print("I sent it to hell")
                }
            })
        }
    }
    
    public func deleteAllTrack (){
        try! musicStore.store.realm.write {
            musicStore.store.realm.deleteAll()
        }
    }
}
class MusicTracks {
    public static var allTracks = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
    public static var allNotes = Array(musicStore.store.realm.objects(note.self).freeze())
}
//struct ContentViewCellModel {
//    var trackID:String
//    var title: String
//    var song : List<note>
//}
//
//struct noteViewModel{
//     var col: Int
//     var row: Int
//     var imgName: String
//}
//
//
//class ContentViewModel: ObservableObject {
//    private var token: NotificationToken?
//    private var myModelResults = try? Realm().objects(musicTrack.self)   // what do we do with this?
//    @Published var cellModels: [ContentViewCellModel] = []
//    
//    init() {
//        token = myModelResults?.observe { [weak self] _ in
//            self?.cellModels = self?.myModelResults?.map { ContentViewCellModel(trackID : $0.trackID, title: $0.title, song: $0.song) } ?? []
//        }
//    }
//    
//    deinit {
//        token?.invalidate()
//    }
//}
//class NoteViewModel: ObservableObject {
//    private var token: NotificationToken?
//    private var myModelResults = try? Realm().objects(note.self)    // what do we do with this?
//    @Published var cellModels: [noteViewModel] = []
//    
//    init() {
//        token = myModelResults?.observe { [weak self] _ in
//            self?.cellModels = self?.myModelResults?.map { noteViewModel(col: $0.col, row: $0.row, imgName: $0.imgName) } ?? []
//        }
//    }
//    
//    deinit {
//        token?.invalidate()
//    }
//}
