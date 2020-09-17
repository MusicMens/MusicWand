//
//  ViewController.swift
//  SamplerDemo
//
//  Created by Shane Dunne, revision history on Githbub.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class PianoViewController: UIViewController {

    let conductor = Conductor.shared
    var isPlaying = false
    var currentSound = 0

    // avoid strange behavior when user touches the on-screen keyboard too close to the edge
    override var prefersStatusBarHidden: Bool {
        return true }
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .all
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        conductor.midi.addListener(self)
        setupUI()
    }

    func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let keyboardView = AKKeyboardView()
        keyboardView.delegate = self
        
        stackView.addArrangedSubview(keyboardView)


        view.addSubview(stackView)

        stackView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true

        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

}

extension PianoViewController: AKKeyboardDelegate {

    func noteOn(note: MIDINoteNumber) {
        DispatchQueue.main.async {
            self.conductor.playNote(note: note, velocity: 100, channel: 0)
        }
    }

    func noteOff(note: MIDINoteNumber) {
        DispatchQueue.main.async {
            self.conductor.stopNote(note: note, channel: 0)
        }
    }
}
extension PianoViewController: AKMIDIListener {

    func receivedMIDINoteOn(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
        DispatchQueue.main.async {
            self.conductor.playNote(note: noteNumber, velocity: velocity, channel: channel)
        }
    }

    func receivedMIDINoteOff(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
        DispatchQueue.main.async {
            self.conductor.stopNote(note: noteNumber, channel: channel)
        }
    }

    func receivedMIDISystemCommand(_ data: [MIDIByte]) {
        // do nothing: silence superclass's log chatter
    }

    // MIDI Setup Change
    func receivedMIDISetupChange() {
        AKLog("midi setup change, midi.inputNames: \(conductor.midi.inputNames)")
        let inputNames = conductor.midi.inputNames
        inputNames.forEach { inputName in
            conductor.midi.openInput(name: inputName)
        }
    }

}
