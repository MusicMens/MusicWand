//
//  MusicSheetView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import RealmSwift

struct MusicSheetView: View {
    @ObservedObject var musicSheetStore = MusicNoteElementStore()
    @State var newMusicSheet: String = ""
    @State var isLinkActive: Bool = false
    @State var musicSheetName: String = ""
    @ObservedObject var musicStores =  musicStore();
    
    var body: some View {
//         _ = musicStores.addTrack(musicStores.makeTrack("String"))
//         _ = musicStores.addTrack(musicStores.makeTrack("String1"))
//         _ = musicStores.addTrack(musicStores.makeTrack("String2"))
//         _ = musicStores.addTrack(musicStores.makeTrack("String3"))
//        _ = musicStores.deleteAllTrack()
//             _ = musicStores.deleteTrackByName("String")
   let realm: Realm = try! Realm()
  let tracks = realm.objects(musicTrack.self)
        return VStack {
                NavigationView{
                    List{
                        ForEach(tracks, id: \.self){ score in
                        NavigationLink(destination: ScoreDetail(score: score)){
                            ScoreRow(score: score)
                        }
                    }.onDelete(perform: delete)
                        
                    }
                }
                .navigationBarTitle(Text("Scores"))
                Button(action: {
                    self.addNewMusicSheet()
                    self.isLinkActive = true
                }, label: {Image(systemName: "goforward.plus").font(.largeTitle)})
                Spacer(minLength: 45)
            }
        }
    
    func delete(at indexSet: IndexSet){
           
    //        musicStores.deleteTrackByID()
        }
    
    func addNewMusicSheet() {
        musicSheetStore.musicSheets.append(MusicNoteElement(id: UUID(), name: newMusicSheet, musicBar: newMusicSheet))
    }
    
    struct MusicSheetView_Previews: PreviewProvider {
        static var previews: some View {
            MusicSheetView()
        }
    }
}











//import SwiftUI
//import RealmSwift
//
//struct MusicSheetView: View {
//    @ObservedObject var musicSheetStore = MusicNoteElementStore()
//    @State var newMusicSheet: String = ""
//    @State var isLinkActive: Bool = false
//    @State var musicSheetName: String = ""
//    @ObservedObject var musicStores =  musicStore();
//
//    var body: some View {
//        _ = musicStores.addTrack(musicStores.makeTrack("String"))
//        //        _ = musicStores.addTrack(musicStores.makeTrack("String1"))
//        //         _ = musicStores.addTrack(musicStores.makeTrack("String2"))
//        //         _ = musicStores.addTrack(musicStores.makeTrack("String3"))
//           //   _ = musicStores.deleteAllTrack()
//          //       _ = musicStores.deleteTrackByName("String")
//            let realm: Realm = try! Realm()
//            let tracks = realm.objects(musicTrack.self)
////
//
//       return  NavigationView {
//            VStack {
//                List {
//                    Text("Recent").font(.title)
//                    Text(musicStores.findTrack().title)
//                  Text(tracks[3].title)
//                    ForEach(tracks) {item in
//                        NavigationLink(destination: MusicSheetEditView(), isActive: self.$isLinkActive) {
//                            HStack {
//                                Image("musicNote")
//                                    .resizable()
//                                    .frame(width: 35, height: 35)
//                                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 1, y: 1)
//                                Text("item.name").font(.headline)
//                            }.padding(3)
//                        }
//                    }
//                }
//                Button(action: {
//                    self.addNewMusicSheet()
//                    self.isLinkActive = true
//
//                }, label: {Image(systemName: "goforward.plus").font(.largeTitle)})
//                Spacer(minLength: 45)
//            }.navigationBarTitle(Text("Music Sheets"))
//        }
//    }
//
//    func addNewMusicSheet() {
//        musicSheetStore.musicSheets.append(MusicNoteElement(id: UUID(), name: newMusicSheet, musicBar: newMusicSheet))
//    }
//
//    struct MusicSheetView_Previews: PreviewProvider {
//        static var previews: some View {
//            MusicSheetView()
//        }
//    }
//}
