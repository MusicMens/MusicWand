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
    
    var body: some View {
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
                NavigationLink(destination: AboutView(), label: {Image(systemName: "goforward.plus").font(.largeTitle)})
                Spacer(minLength: 45)
            }
            .navigationBarTitle(Text("Scores"))
            NavigationLink(destination: AboutView(), label: {Image(systemName: "goforward.plus").font(.largeTitle)})
            Spacer(minLength: 45)
        }
    }
    
    func delete(at indexSet: IndexSet){
    }
    
}


struct MusicSheetView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
