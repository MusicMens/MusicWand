//
//  m.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import RealmSwift
struct ScoreDetail: View {
    var score: musicTrack
    var body: some View {
        VStack{
            Text("this is the dynamic score")
            Text(score.title)
        }
        .navigationBarTitle(Text(score.title), displayMode: .inline)
}
}
