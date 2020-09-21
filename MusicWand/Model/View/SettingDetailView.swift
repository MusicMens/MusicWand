//
//  SettingDetailView.swift
//  MusicWand
//
//  Created by ethancr0wn on 2020/09/01.
//  Copyright © 2020 ethancr0wn. All rights reserved.
//

import SwiftUI

struct SettingDetailView: View {
    var activePage: String
    var body: some View {
        VStack{
            containedView()
        }
        
    }
    func containedView() -> AnyView {
         switch activePage {
         case "AboutView": return AnyView(AboutView())
         default:
            return AnyView(Image("ComingSoon").foregroundColor(Color.myPurple).frame(width: 80, height: 43)
//            Text("Coming Soon").font(.custom("Chalkduster", size: 46))
//         .foregroundColor(.myPurple)
//         .multilineTextAlignment(.center)
            )
      }
    }
}

struct SettingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingDetailView(activePage: "")
    }
}
