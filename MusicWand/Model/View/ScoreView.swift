//
//  ScoreView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    
    let notes: [Note]
    @State private var movingNoteLocation = CGPoint(x: 200, y: 300)
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ScoreGrid(bounds: geo.frame(in: .local))
                    .stroke()
                
                ForEach(self.notes, id: \.self) { note in
                    Image(note.imgName)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .position(notePosition(bounds: geo.frame(in: .local), col: note.col, row: note.row))
                    .gesture(DragGesture().onChanged({ value in
                        self.movingNoteLocation = value.location
                    }).onEnded({ value in
                        print(value.location)
                    })
                    )
                }
            }
            
        }
    }
}


func originX(bounds: CGRect) -> CGFloat {
    return bounds.size.width * 0.1
}

func originY(bounds: CGRect) -> CGFloat {
    return bounds.size.height * 0.1
}

func cellWidth(bounds: CGRect) -> CGFloat {
    let cols: Int = 4
    return (bounds.size.width * 0.9) / CGFloat(cols + 1)
}
 func cellHeight(bounds: CGRect) -> CGFloat {
    let rows: Int = 19
    return  (bounds.size.height * 0.3) / CGFloat(rows)
}


 func notePosition(bounds: CGRect, col: Int, row: Int) -> CGPoint {
    let x = originX(bounds: bounds) + CGFloat(col) * cellWidth(bounds: bounds)
    let y = originY(bounds: bounds) + CGFloat(row) * cellHeight(bounds: bounds)
    return CGPoint(x: x, y: y)
}




struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(notes: [Note].init())
    }
}

