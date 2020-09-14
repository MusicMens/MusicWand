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
    
    @State private var onSubmit = false
    var body: some View {
        NavigationView{
            VStack{
                Text("Track Name").font(.headline).padding()
            
                TextField("Title" , text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
//                NavigationLink(destination: ScoreView(trackData: musicTrack(), scoreModel: ScoreModel()), isActive: self.$onSubmit){EmptyView()}
                Button("Done") {
                   
                let track = self.score.makeTrack(self.title)
                self.score.addTrack(track)
                self.onSubmit = true
        
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
