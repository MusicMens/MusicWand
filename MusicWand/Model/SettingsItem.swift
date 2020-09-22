//
//  SettingsItem.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import Foundation


struct SettingsItem: Identifiable {
    var id:UUID = UUID()
    var name:String
    var icon:String
    var viewName:String
}


var settingsItems:[SettingsItem] = [
    SettingsItem(name: "User", icon: "person", viewName: "User"),
    SettingsItem(name: "Music Sheets", icon: "list.dash", viewName: "MusicSheet"),
    SettingsItem(name: "Account Settings", icon: "gear", viewName: "SettingsView"),
    SettingsItem(name: "About Music Wand", icon: "music.house", viewName: "AboutView"),
    SettingsItem(name: "Our Team", icon: "person.3", viewName: "OurTeamView"),
]
