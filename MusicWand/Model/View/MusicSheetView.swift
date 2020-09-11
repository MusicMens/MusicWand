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
                            print("MusicSheetView\(self.model.cellModels)")
                        }
                    }
                    Button(action: {
                        print("I added chicken")
                        let alertHC = UIHostingController(rootView: newTrackAlertView())

                            alertHC.preferredContentSize = CGSize(width: 300, height: 200)
                            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

                            UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)

                        
//                        self.countUntitled += 1
//                        let track = self.score.makeTrack("Untitled\(self.countUntitled)")
//                        self.score.addTrack(track)
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
       MusicSheetView()
        
    }
}
