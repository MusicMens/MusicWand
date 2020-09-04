//
//  ContentView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    
    
    init() {
       UITabBar.appearance().backgroundColor = UIColor.darkGray
    let scorePDFCreator = ScorePDFCreator()
        let output = scorePDFCreator.createScore()
    let url = getDocumentsDirectory().appendingPathComponent("magicWand.pdf")
    try? output.write(to: url)
    print(url)
    }
    
   
    @State private var selectedTab = 2
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
                  PianoView().tabItem {
                      Image(systemName: "music.note")
                  }.tag(1)
                  MusicSheetView().tabItem {
                      Image(systemName: "wand.and.stars.inverse")
                  }.tag(2)
                  SettingView().tabItem {
                      Image(systemName: "slider.horizontal.3")
                  }.tag(3)
              }//.accentColor(.black)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
