//
//  AboutView.swift
//  MusicWand
//
//  Created by mattia marcenta on 22/09/2020.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("Music Wand")
                .font(.custom("Chalkduster", size: 45))
                .foregroundColor(.myPurple)
                .multilineTextAlignment(.center)
                .frame(width: 400.0)
            Image("githubLogo")
                .resizable()
                .frame(width: 27, height: 27)
                .background(Color.myPurple)
                .cornerRadius(4)
                .onTapGesture {
                    let url = URL.init(string: "https://github.com/MusicMens/MusicWandPog")
                    guard let gitURL = url, UIApplication.shared.canOpenURL(gitURL) else { return }
                    UIApplication.shared.open(gitURL)
            }.padding()
            VStack(alignment: .leading) {
                Text("What is Music Wand? 🎼 🧙 ✍️").bold().multilineTextAlignment(.leading)
            
                Text("MusicWand is a simple, easy-to-use music composition app. Just create a new score and start adding in notes! Hear your song played back to you when you press play!")
                    .multilineTextAlignment(.leading).padding(5)
            }.padding()
            VStack (alignment: .leading){
                Text("Awesome Features 🎹 🎼").bold().multilineTextAlignment(.leading)
                Text("Great drag & drop functionality!").multilineTextAlignment(.leading).padding(5)
               
                Text("Simple selection of notes & Easy to use controls").multilineTextAlignment(.leading).padding(5)
                Text("A cool keyboard! Only one octave for now, but it works like a charm! Use this to do some quick improvisation before you write it down! 🎶").multilineTextAlignment(.leading).padding(5)
            }.padding()
           
        }.padding(5)
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
