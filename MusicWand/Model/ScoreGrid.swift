//
//  ScoreGrid.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import Foundation
import SwiftUI







struct ScoreGrid: Shape {
    

    
    let bounds: CGRect
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cols: Int = 4
        let rows: Int = 19
        let origX: CGFloat = originX(bounds: bounds)
        let origY: CGFloat = originY(bounds: bounds)
        let cellwidth = cellWidth(bounds: bounds)
        let cellheight = cellHeight(bounds: bounds)
        for row in 0..<rows {
            path.move(to: CGPoint(x: origX, y: origY + CGFloat(row) * cellheight))
            path.addLine(to: CGPoint(x: origX + (bounds.size.width * 0.8), y: origY + CGFloat(row) * cellheight))
        }
        for col in 0..<cols {
            path.move(to: CGPoint(x:origX + CGFloat(col + 1) * cellwidth, y: origY ))
            path.addLine(to: CGPoint(x: origX + CGFloat(col + 1) * cellwidth, y: origY + bounds.size.height * 0.3))
        }
        return path
    }
}

