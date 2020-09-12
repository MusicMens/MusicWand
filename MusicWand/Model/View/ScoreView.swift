//
//  ScoreView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import RealmSwift

struct ScoreView: View {
    var trackData : ContentViewCellModel
    let colsRowsData =  note()
    @ObservedObject var scoreModel: ScoreModel
    @State private var movingNoteLocation = CGPoint(x: 200, y: 200)
    @State private var fromPoint: CGPoint?
    @State private var movingNote: Note?
    var sequencer = Conductor.shared
    var body: some View {

        NavigationView {
            VStack {
                ZStack {
                    GeometryReader { geo in
                        ScoreGrid(bounds: geo.frame(in: .local))
                            .stroke()
                        
                        ForEach(Array(self.trackData.song), id: \.self) { note in
                            Image(note.imgName)
                                .resizable()
    //                            .frame(width: cellWidth(bounds: geo.frame(in: .local)), height: cellHeight(bounds: geo.frame(in: .local)))
                                .frame(width: 30, height: 30)
                                .position(notePosition(bounds: geo.frame(in: .local), col: note.col, row: note.row))
                                .gesture(DragGesture().onChanged({ value in
                                    self.movingNoteLocation = value.location
                                    if self.fromPoint == nil {
                                        self.fromPoint = value.location
                                        let (fromCol, fromRow) = xyToColRow(bounds: geo.frame(in: .local), x: value.location.x, y: value.location.y)
                                        self.movingNote = self.scoreModel.noteAt(col: fromCol, row: fromRow)
                                    }
                                }).onEnded({ value in
                                    let toPoint: CGPoint = value.location
                                    if let fromPoint = self.fromPoint {
                                        let (fromCol, fromRow) = xyToColRow(bounds: geo.frame(in: .local), x: fromPoint.x, y: fromPoint.y)
                                        let (toCol, toRow) = xyToColRow(bounds: geo.frame(in: .local), x: toPoint.x, y: toPoint.y)
                                        self.colsRowsData.col = toCol
                                        self.colsRowsData.row = toRow
                                        let realm = try! Realm()
                                        let tracks = realm.objects(musicTrack.self)
                                        
                                        print(tracks)
                                        
                                        
                                        print("from col:(\(fromCol), from row: \(fromRow) to col:\(toCol), to row: \(toRow)")
                                        self.moveNote(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
                                    }
                                    
                                    self.fromPoint = nil
                                    self.movingNote = nil
                                }))
                            
                        }
                        if self.movingNote != nil {
                            Image(self.movingNote!.imgName)
                                .resizable()
    //                           .frame(width: cellWidth(bounds: geo.frame(in: .local)), height: cellHeight(bounds: geo.frame(in: .local)))
                                .frame(width: 30, height: 30)
                                .position(self.movingNoteLocation)
                        }
                        
                        
                    }
                    
                }
    //            Button(action:{}){Text("new Note")}
                Button(action: {
                    self.sequencer.play()
                }, label: {Image(systemName: "play").font(.largeTitle)} )
            }
        }.navigationBarTitle(self.trackData.title)
    }
    
    func moveNote(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        scoreModel.moveNote(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
    }
    
    func createNote() {
        
    }
    
}

func xyToColRow(bounds: CGRect, x: CGFloat, y: CGFloat) -> (Int, Int) {
    let col: Int = Int((x - originX(bounds: bounds)) / cellWidth(bounds: bounds) + 0.5)
    let row: Int = Int((y - originY(bounds: bounds)) / cellWidth(bounds: bounds) + 0.5)
    return (col, row)
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
    let y = originY(bounds: bounds) + CGFloat(row) * cellWidth(bounds: bounds)
    return CGPoint(x: x, y: y)
}





//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView(scoreModel: ScoreModel())
//    }
//}

