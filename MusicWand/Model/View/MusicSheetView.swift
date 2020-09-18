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
    @State var allTrack = MusicTracks.allTracks
    @State var allNote = MusicTracks.allNotes
    @State var showsAlert = false
    @State var countUntitled = 0;
    @State var title = ""
    @State var playPauseButton = false
    var body: some View {
        return
            NavigationView{
                VStack{
                    List{
                        ForEach(allTrack , id: \.self){ score in
                            NavigationLink(destination: ScoreView(trackData: score, scoreModel: ScoreModel(inputnotes: Array(score.song)))){
                                Button( action: {
                                    //self.sequencer.playPause()
                                    self.playPauseButton.toggle()
                                }, label: {
                                    PlayPauseButton(active: self.playPauseButton)
                                }).buttonStyle(PlainButtonStyle()) .padding()
                                
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
                    Button(action: {
                        self.showsAlert = true
                    },label: {Image(systemName: "plus.circle.fill").resizable().frame(width: 55, height: 55)})
                        .padding(20)
                }.alert(isPresented: $showsAlert, TextAlert(title: "Set New Track Title", action: {
                    let trackTitle = ($0 ?? "")
                    if trackTitle != "" {
                        let track = self.musicStores.makeTrack(trackTitle)
                        self.musicStores.addTrack(track)
                        self.allTrack = Array(musicStore.store.realm.objects(musicTrack.self).freeze())
                        self.allNote = Array(musicStore.store.realm.objects(note.self).freeze())
                    }
                    self.showsAlert = false
                })).navigationBarTitle(Text("Scores"))
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
