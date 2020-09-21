//
//  MusicSheetView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import RealmSwift
import AudioKit

struct MusicSheetView: View {
    var musicStores = musicStore.store
    @State var allTrack = MusicTracks.allTracks
    @State var allNote = MusicTracks.allNotes
    @State var showsAlert = false
    @State var countUntitled = 0;
    @State var title = ""
    @State var playPauseButton = false
    let sequencer = Conductor.shared
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.purple]

        //Use this if NavigationBarTitle is with displayMode = .inline
       // UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Chalkduster", size: 45)!, .foregroundColor : UIColor.purple]
    }
    var body: some View {
        return
            NavigationView{
                VStack{
                    List{
                        ForEach(allTrack , id: \.self){ score in
                            NavigationLink(destination: ScoreView(trackData: score, scoreModel: ScoreModel(inputnotes: Array(score.song)))){
                                Button( action: {
                                    makeSequence(Array(score.song))
                                    self.sequencer.playPause()
//                                    self.playPauseButton.toggle()
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
                    },label: {Image(systemName: "plus.circle.fill").resizable().frame(width: 55, height: 55).foregroundColor(Color.purple)})
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
}



func makeSequence(_ notes: [note] ){
    Conductor.shared.clearSequence()
    var pos = 0.0
    var col = 0
    for noteToPlay in notes.sorted(by: {$0.col < $1.col}) {
        if noteToPlay.col > col {
            pos = pos + 0.6 * Double((noteToPlay.col - col))
            col = noteToPlay.col
        }
        var midiNoteNumber: Int = 0
        if noteToPlay.row == 0 {
             midiNoteNumber = 98
        }
        if noteToPlay.row == 1 {
             midiNoteNumber = 96
        }
        if noteToPlay.row == 2 {
             midiNoteNumber = 95
        }
        if noteToPlay.row == 3 {
             midiNoteNumber = 93
        }
        if noteToPlay.row == 4 {
             midiNoteNumber = 91
        }
        if noteToPlay.row == 5 {
             midiNoteNumber = 89
        }
        if noteToPlay.row == 6 {
             midiNoteNumber = 88
        }
        if noteToPlay.row == 7 {
             midiNoteNumber = 86
        }
        if noteToPlay.row == 8 {
             midiNoteNumber = 84
        }
        if noteToPlay.row == 9 {
             midiNoteNumber = 83
        }
        if noteToPlay.row == 10 {
             midiNoteNumber = 81
        }
        if noteToPlay.row == 11 {
             midiNoteNumber = 79
        }
        if noteToPlay.row == 12 {
             midiNoteNumber = 77
        }
        if noteToPlay.row == 13 {
             midiNoteNumber = 76
        }
        if noteToPlay.row == 14 {
             midiNoteNumber = 74
        }
        if noteToPlay.row == 15 {
             midiNoteNumber = 72
        }
        if noteToPlay.row == 16 {
             midiNoteNumber = 71
        }
        if noteToPlay.row == 17 {
             midiNoteNumber = 69
        }
        if noteToPlay.row == 18 {
             midiNoteNumber = 67
        }
        Conductor.shared.sequencer.tracks[0].add(noteNumber: MIDINoteNumber(midiNoteNumber), velocity: 127, position: AKDuration(beats:pos), duration: AKDuration(beats: 0.5))

    }

}

//struct MusicSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//       MusicSheetView()
//
//    }
//}

