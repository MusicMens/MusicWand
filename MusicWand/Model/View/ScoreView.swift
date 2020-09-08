//
//  ScoreView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    
    var score: musicTrack
    let notes: [Note]
    @State private var movingNoteLocation = CGPoint(x: 200, y: 300)
    
    var body: some View {
        VStack{
            Text("score view baby")
            Text(score.title)
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
}


func originX(bounds: CGRect) -> CGFloat {
    return bounds.size.width * 0.1
}

func originY(bounds: CGRect) -> CGFloat {
    return bounds.size.height * 0.1
}

func cellWidth(bounds: CGRect) -> CGFloat {
    let cols: Int = 4
    return (bounds.size.width * 0.8) / CGFloat(cols + 1)
}
func cellHeight(bounds: CGRect) -> CGFloat {
    let rows: Int = 19
    return  (bounds.size.height * 0.3) / CGFloat(rows - 1)
}


 func notePosition(bounds: CGRect, col: Int, row: Int) -> CGPoint {
    let x = originX(bounds: bounds) + CGFloat(col + 1) * cellWidth(bounds: bounds) + 5
    let y = originY(bounds: bounds) + CGFloat(row - 1) * cellHeight(bounds: bounds)
    return CGPoint(x: x, y: y)
}




struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(notes: [Note].init())
    }
}

