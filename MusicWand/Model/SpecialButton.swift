//
//  SpecialButton.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/18.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct RepeatButton: View {
    var active = false
    var body: some View {
       
        HStack {
            if active {
                Image(systemName:"repeat")
                .resizable()
                    .frame(width: 40, height: 40).foregroundColor(Color.orange)
                
            }else {
                Image(systemName:"repeat")
                .resizable()
                .frame(width: 40, height: 40).foregroundColor(Color.purple)
                 
            }
        }
        
    }
}

struct SpecialButton_Previews: PreviewProvider {
    static var previews: some View {
        RepeatButton()
    }
}
