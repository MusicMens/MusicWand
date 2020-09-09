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
    let notes = [Note]()
    var body: some View {
//         score.deleteAllTrack()
        print("YOLO")
        return
            NavigationView{
                VStack{
                    List{
                        ForEach(allTracks, id: \.self){ score in
                            NavigationLink(destination: ScoreView(scoreModel: ScoreModel())){
                                ScoreRow(score: score)
                            }
                        }.onDelete(perform: delete)
                    }
                    Button(action: {
                        print("I added chicken")
                        let track = self.score.makeTrack("untitled1")
                        self.score.addTrack(track)
                        self.sendToHell.toggle();
                    }, label: {Image(systemName: "goforward.plus").font(.largeTitle)})
                    Spacer(minLength: 45)
                }
            }
            .navigationBarTitle(Text("Scores"))

    }

    func delete(at indexSet: IndexSet){
    }
    
}


struct MusicSheetView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
