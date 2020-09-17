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
    let cols: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rows: Int = 19
        let origX: CGFloat = originX(bounds: bounds)
        let origY: CGFloat = originY(bounds: bounds)
        let cellwidth = cellWidth(bounds: bounds)
        let cellheight = cellHeight(bounds: bounds)
        for row in 0..<rows {
            if(row == 5 || row == 7 || row == 9 || row == 11 || row  == 13){
            path.move(to: CGPoint(x: origX, y: origY + CGFloat(row) * cellheight))
            path.addLine(to: CGPoint(x: origX + cellwidth * CGFloat(cols), y: origY + CGFloat(row) * cellheight))
            }
        
    }
        for col in 0..<cols {
            if col > 0 {
            path.move(to: CGPoint(x:origX + CGFloat(col) * cellwidth, y: origY + 5 * cellheight))
            path.addLine(to: CGPoint(x: origX + CGFloat(col) * cellwidth, y: origY + 13 * cellheight))
            }}
        return path
    }
}

