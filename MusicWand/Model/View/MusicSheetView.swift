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
    @ObservedObject var score = musicStore()
    @State var sendToHell = false
    @State var allTracks = realm.objects(musicTrack.self)
     @ObservedObject var model = ContentViewModel()
    
    let notes = [Note]()
    var body: some View {
//         score.deleteAllTrack()
        print("YOLO")
        return
            NavigationView{
                VStack{
                    List{
                        ForEach(model.cellModels , id: \.trackID){ score in
                            NavigationLink(destination: ScoreView(scoreGame: ScoreGame())){
                                ScoreRow(score: self.model.cellModels[0])////
                            }
                        }.onDelete{ indexSet in
                            let realm = try? Realm()
                            if let index = indexSet.first, let myModel = realm?.objects(musicTrack.self).filter("trackID = %@", self.model.cellModels[index].trackID).first {
                                try? realm?.write {
                                    realm?.delete(myModel)
                                }
                            }
                        }
                    }
                    Button(action: {
                        print("I added chicken")
                        let track = self.score.makeTrack("untitled1")
                        self.score.addTrack(track)
                        self.sendToHell.toggle();
                    },label: {Image(systemName: "goforward.plus").font(.largeTitle)})
                    Spacer(minLength: 45)
                }
            }
            .navigationBarTitle(Text("Scores"))

    }

    func deleteRow(at indexSet: IndexSet){
    }
    
}


struct MusicSheetView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
