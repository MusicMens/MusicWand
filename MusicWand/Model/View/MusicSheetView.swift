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
    @ObservedObject var model = ContentViewModel()
    @State var countUntitled = 0;
    var body: some View {
        return
            NavigationView{
                VStack{
                    List{
                        ForEach(model.cellModels , id: \.trackID){ score in
                            NavigationLink(destination: ScoreView(scoreModel: ScoreModel())){
                                ScoreRow(score: score)
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
                        self.countUntitled += 1
                        let track = self.score.makeTrack("Untitled\(self.countUntitled)")
                        self.score.addTrack(track)
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
