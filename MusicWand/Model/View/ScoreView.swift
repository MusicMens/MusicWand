//
//  ScoreView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/08.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import RealmSwift
import AudioKit

struct ScoreView: View {
    var trackData : musicTrack
    @State private var colsRowsData =  Note(col:0, row:0 , imgName: "MusicNote")
    @State private var movingNoteLocation = CGPoint(x: 200, y: 200)
    @State private var fromPoint: CGPoint?
    @State private var movingNote: Note?
    @State var notes = MusicTracks.allNotes
    @State var tempo = ""
    @State var enteredNumber = "100"
    @State var repeatButtonPressed = false
    @State var playPauseButtonPressed = false
    @ObservedObject var scoreModel:ScoreModel
    var sequencer = Conductor.shared
    var body: some View {
        makeSequence(notes: self.scoreModel.notes)

        return VStack {
            VStack(spacing: 10) {
                
                HStack {
                    VStack {
                        
                        TextField("\(self.enteredNumber)",text: $tempo)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80, height: 43)
                        
                        Button("set tempo") {
                            print(self.tempo, self.enteredNumber)
                            self.enteredNumber = self.tempo
                            self.sequencer.setTempo(Int(self.enteredNumber)!)
                            self.hideKeyboard()
                        }.padding(3)
                            
                            .foregroundColor(.white)
                            .background(Color.purple)
                            .cornerRadius(5)
                    }.padding()
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName:"arrow.left.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35).foregroundColor(Color.purple)
                    }
                    Button(action: {}) {
                        Image(systemName: "arrow.right.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35).foregroundColor(Color.purple)
                    }.padding()
                    Button(action: {}) {
                        Image(systemName:"arrow.up.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35).foregroundColor(Color.purple)
                    }.padding()
                    Button(action: {}) {
                        Image(systemName: "arrow.down.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35).foregroundColor(Color.purple)
                    }
                }.padding(Edge.Set(rawValue: 100),140)
            }
            HStack {
                VStack {
                    GeometryReader { fullView in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                GeometryReader { geo in
                                    ScoreGrid( bounds: geo.frame(in: .local), cols: self.scoreModel.lastCol() )
                                        .stroke()
                                    Image("TrebleClef").resizable().frame(width: geo.frame(in: .local).width * 0.13, height: geo.frame(in: .local).height * 0.28) .position(notePosition(bounds: geo.frame(in: .local), col:0, row: 11))
                                    ForEach(Array(self.scoreModel.notes), id: \.id) { note in
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
                                .frame(width: 410, height: 350)
                                ForEach(0..<55)  { index in
                                    Text("----")
                                        .foregroundColor(Color.white)
                                    
                                }
                            }
                        }
                    }
                    
                }
                
            }
            
            
            
            HStack(spacing: 18) {
                Button(action: {
                    self.scoreModel.addNote(track: self.trackData)}) {
                        Text("New note")
                            .font(.headline)
                        
                        
                }.padding(5)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(5)
                Button(action: {
                   // self.scoreModel.deleteNotes()
                }) {
                    Text("delete note")
                        .font(.headline)
                    
                }.padding(5)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(5)
                Button(action: {
                    self.scoreModel.clearNotes()
                }) {
                    Text("Clear all")
                        .font(.headline)
                    
                }.padding(5)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(5)
            }
            
            
            VStack {
                HStack {
                    
                    Button(action: {self.sequencer.rewind()}) {
                        Image(systemName:"backward.end.fill")
                            .resizable()
                            .frame(width: 30, height: 30).foregroundColor(Color.purple)
                    }.padding(25)
                    Button(action: {
                        self.sequencer.playPause()}) {
                            Image(systemName: "playpause.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                    }.padding(50).foregroundColor(Color.purple)
  Button(action: {
                        self.sequencer.toggleLoop()
                        self.repeatButtonPressed.toggle()
                        
                    }, label: {
                        RepeatButton(active: repeatButtonPressed)
                    }).padding()
                    
                }
            }
            Spacer()
        }.navigationBarTitle(self.trackData.title)
        
        
        
        
    }
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    
    func moveNote(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        scoreModel.moveNote(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
    }
    
    func createNote() {
        
    }
    
}

func xyToColRow(bounds: CGRect, x: CGFloat, y: CGFloat) -> (Int, Int) {
    let col: Int = Int(round((x - originX(bounds: bounds)) / cellWidth(bounds: bounds)))
    var row: Int = Int(round((y - originY(bounds: bounds)) / cellHeight(bounds: bounds)))
    if row < 0 {
        row = 0
    }
    if row > 18 {
        row = 18
    }
    return (col, row)
}


func originX(bounds: CGRect) -> CGFloat {
    return bounds.size.width * 0.1
}

func originY(bounds: CGRect) -> CGFloat {
    return bounds.size.height * 0.1
}

func cellWidth(bounds: CGRect) -> CGFloat {
    
    return bounds.size.width * 0.15
}
func cellHeight(bounds: CGRect) -> CGFloat {
    let rows: Int = 19
    return  (bounds.size.height * 0.3) / CGFloat(rows)
}


func notePosition(bounds: CGRect, col: Int, row: Int) -> CGPoint {
    let x = originX(bounds: bounds) + CGFloat(col) * cellWidth(bounds: bounds)
    let y = originY(bounds: bounds) + CGFloat(row) * cellHeight(bounds: bounds) - (bounds.size.height * 0.03)
    return CGPoint(x: x, y: y)
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

func makeSequence(notes: Set<Note> ){
    Conductor.shared.clearSequence()
    var pos = 0.0
    var col = 0
    for note in notes.sorted(by: {$0.col < $1.col}) {
        if note.col > col {
            print("increasing position")
            pos = pos + Double(0.6 * (note.col - col))
            col = note.col
        }
        print("adding note")
        var midiNoteNumber: Int = 0
        if note.row == 0 {
             midiNoteNumber = 98
        }
        if note.row == 1 {
             midiNoteNumber = 96
        }
        if note.row == 2 {
             midiNoteNumber = 95
        }
        if note.row == 3 {
             midiNoteNumber = 93
        }
        if note.row == 4 {
             midiNoteNumber = 91
        }
        if note.row == 5 {
             midiNoteNumber = 89
        }
        if note.row == 6 {
             midiNoteNumber = 88
        }
        if note.row == 7 {
             midiNoteNumber = 86
        }
        if note.row == 8 {
             midiNoteNumber = 84
        }
        if note.row == 9 {
             midiNoteNumber = 83
        }
        if note.row == 10 {
             midiNoteNumber = 81
        }
        if note.row == 11 {
             midiNoteNumber = 79
        }
        if note.row == 12 {
             midiNoteNumber = 77
        }
        if note.row == 13 {
             midiNoteNumber = 76
        }
        if note.row == 14 {
             midiNoteNumber = 74
        }
        if note.row == 15 {
             midiNoteNumber = 72
        }
        if note.row == 16 {
             midiNoteNumber = 71
        }
        if note.row == 17 {
             midiNoteNumber = 69
        }
        if note.row == 18 {
             midiNoteNumber = 67
        }
        Conductor.shared.sequencer.tracks[0].add(noteNumber: MIDINoteNumber(midiNoteNumber), velocity: 127, position: AKDuration(beats:pos), duration: AKDuration(beats: 0.5))

    }

}


//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView(scoreModel: ScoreModel())
//    }
//}

