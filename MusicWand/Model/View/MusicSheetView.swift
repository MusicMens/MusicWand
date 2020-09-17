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
    var musicStores = musicStore.store
//    @State public var allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
    @State var allTrack = MusicTracks.allTracks
    @State var allNote = MusicTracks.allNotes
       // @ObservedObject var score = musicStore()
   // @ObservedObject var model = ContentViewModel()
    @State var countUntitled = 0;
    @State var title = ""
    var body: some View {
        return
            NavigationView{
                VStack{
                    List{
                        ForEach(allTrack , id: \.self){ score in
                            NavigationLink(destination: ScoreView(trackData: score, scoreModel: ScoreModel(inputnotes: Array(score.song)))){
                                ScoreRow(score: score)
                
                            }
                             
                        }
                     .onDelete{ indexSet in
                        let index = indexSet.first
                        let id = self.allTrack[index!].trackID
                        let track = self.musicStores.findTrack(id)
                        self.allTrack = self.allTrack.enumerated().filter{!indexSet.contains($0.offset)}.map{$0.element}
                        
                        try! self.musicStores.realm.write{
                            self.musicStores.realm.delete(track!)
                            }
                        }
                    }
                    TextField("Make a new track", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        let track = self.musicStores.makeTrack(self.title)
                        self.musicStores.addTrack(track)
                        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
                        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())
//                        let alertHC = UIHostingController(rootView: newTrackAlertView())
//
//                            alertHC.preferredContentSize = CGSize(width: 300, height: 200)
//                            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet
//
//                            UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)

                        
//                        self.countUntitled += 1
//                        let track = self.score.makeTrack("Untitled\(self.countUntitled)")
//                        self.score.addTrack(track)
                    },label: {Image(systemName: "plus.circle.fill").resizable().frame(width: 55, height: 55)})
                    .padding(20)
                }.navigationBarTitle(Text("Scores"))
            }
            

    }

    func deleteRow(at indexSet: IndexSet){
    }
    
}


//struct MusicSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//       MusicSheetView()
//
//    }
//}
