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
    var score: ContentViewCellModel
    
    var body: some View {
        Text(score.title)
    }
}


