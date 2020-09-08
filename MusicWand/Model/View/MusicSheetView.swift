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
    
    var body: some View {
        let realm: Realm = try! Realm()
        let tracks = realm.objects(musicTrack.self)
        return
            NavigationView{
                VStack{
                    List{
                        ForEach(tracks, id: \.self){ score in
                            NavigationLink(destination: ScoreDetail(score: score)){
                                ScoreRow(score: score)
                            }
                        }.onDelete(perform: delete)
                    }
                    Button(action: {
                        print("I added chicken")
                        let track = self.score.makeTrack("untitled")
                        self.score.addTrack(track)
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
