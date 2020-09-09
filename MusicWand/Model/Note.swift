//
//  Note.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import Foundation
import SwiftUI


struct Note: Hashable {
    var id = UUID()
    let col: Int
    let row: Int
    let imgName: String
}
