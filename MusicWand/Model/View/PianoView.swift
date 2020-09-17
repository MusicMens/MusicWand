//
//  PianoView.swift
//  HowToSuffer
//
//  Created by Code Chrysalis on 2020/09/16.
//  Copyright © 2020 MusicMens. All rights reserved.
//

import SwiftUI

struct PianoView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> PianoViewController {
        let pianoViewController = PianoViewController()
        
        return pianoViewController
    }
    
    func updateUIViewController(_ uiViewController: PianoViewController, context: Context) {
    }
}
