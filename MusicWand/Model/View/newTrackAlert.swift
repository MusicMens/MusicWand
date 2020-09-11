//
//  newTrackAlert.swift
//  MusicWand
//
//  Created by mattia marcenta on 10/09/2020.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import RealmSwift

struct newTrackAlertView: View {
    @State var title = "Untitled"
    @ObservedObject var score = musicStore()
    @ObservedObject var model = ScoreModel()
//    @ObservedObject var viewModel = ContentViewCellModel()
    
    @State var onSubmit = false
    var body: some View {
        NavigationView{
            VStack{
                Text("Track Name").font(.headline).padding()
            
                TextField("Title" , text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                let track = self.score.makeTrack(self.title)
                self.score.addTrack(track)
//                    NavigationLink(destination: ScoreView(scoreModel: ScoreModel())){
//                        ScoreRow(score: self.model)
//                    }
        
                })
                {
                    Text("Done")
                }
         }
        }
    }
}

struct newTrackAlertView_Previews: PreviewProvider {
    static var previews: some View {
        newTrackAlertView()
    }
}
