//
//  SettingView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @State private var showModal:Bool = false
    @State private var activePage:String = ""
    var body: some View {
        VStack {
            Image("musicNote")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50, alignment: .center)
            .padding()
            VStack {
                Text("Settings")
                    .font(.title)
                    .foregroundColor(.primary)
                Text("select your settings")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                List {
                    ForEach(0..<settingsItems.count) { index in
                        Group{
                            HStack {
                                Image(systemName:settingsItems[index].icon)
                                Text(settingsItems[index].name)
                                .padding(10)
                                
                            }
                        }.onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.showModal.toggle()
                        self.activePage = settingsItems[index].viewName
                            
                        })
                        
                    }.sheet(isPresented: $showModal, content: {
                        SettingDetailView(activePage: self.activePage)
                    })
                    Spacer()
            }
            Spacer()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
}
