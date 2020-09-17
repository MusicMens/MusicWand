//
//  AboutView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Music Wand app team")
                    .font(.largeTitle)
                HStack {
                    Text("Austin")
                    Image("austin").resizable().frame(width: 50, height: 50)
                    Image("austin-1").resizable().frame(width: 50, height: 50)
                    
                }.padding()
                HStack {
                    Text("Mattia")
                    Image("mattia").resizable().frame(width: 50, height: 50)
                    Image("mattia-1").resizable().frame(width: 50, height: 50)
                    
                }.padding()
                HStack {
                    Text("Jesus")
                    Image("jesus").resizable().frame(width: 50, height: 50)
                    Image("jesus-1").resizable().frame(width: 50, height: 50)
                    
                }.padding()
                HStack {
                    Text("Scott")
                    Image("scott").resizable().frame(width: 50, height: 50)
                    Image("scott-1").resizable().frame(width: 50, height: 50)
                    
                    }.padding()
                .font(.body)
            }.padding()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
