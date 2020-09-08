//
//  ScoreRow.swift
//  MusicWand
//
//  Created by Code Chrysalis on 2020/09/04.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import RealmSwift
struct ScoreRow: View {
    var score: musicTrack
    
    var body: some View {
        Text(score.title)
    }
}

struct ScoreRow_Previews: PreviewProvider {
    static var previews: some View {
         let realm: Realm = try! Realm()
        let tracks = realm.objects(musicTrack.self)

        return Group{
            ScoreRow(score: tracks[0])
            ScoreRow(score: tracks[1])
            ScoreRow(score: tracks[2])
        }
    }
}
