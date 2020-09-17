//
//  Conductor.swift
//  SamplerDemo
//
//  Created by Shane Dunne, revision history on Githbub.
//  Copyright © 2018 AudioKit. All rights reserved.
//
import AudioKit

func offsetNote(_ note: MIDINoteNumber, semitones: Int) -> MIDINoteNumber {
    let nn = Int(note)
    return (MIDINoteNumber)(semitones + nn)
}

class PianoConductor {

    static let shared = PianoConductor()

    let midi = AKMIDI()
    var sampler: AKSampler

    var pitchBendUpSemitones = 2
    var pitchBendDownSemitones = 2

    var synthSemitoneOffset = 0

    init() {

        // MIDI Configure
        midi.createVirtualPorts()
        midi.openInput(name: "Session 1")
        midi.openOutput()

        // Session settings
        //AKAudioFile.cleanTempDirectory()
        AKSettings.bufferLength = .medium
        AKSettings.enableLogging = true

        // Signal Chain
        sampler = AKSampler()

        // Set up the AKSampler
        setupSampler()

        // Set Output & Start AudioKit
        AudioKit.output = sampler
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start")
        }
    }

    private func setupSampler() {
        // Example (below) of loading compressed sample files without a SFZ file
        //loadAndMapCompressedSampleFiles()
        // Preferred method: use SFZ file
        // You can download a small set of ready-to-use SFZ files and samples from
        // http://audiokit.io/downloads/ROMPlayerInstruments.zip
        // see loadSamples(byIndex:) below
        sampler.attackDuration = 0
        sampler.decayDuration = 0
        sampler.sustainLevel = 1
        sampler.releaseDuration = 2

//        sampler.filterEnable = true
//        sampler.filterCutoff = 20.0
//        sampler.filterAttackDuration = 1.0
//        sampler.filterDecayDuration = 1.0
//        sampler.filterSustainLevel = 0.5
//        sampler.filterReleaseDuration = 10.0
    }

    func addMIDIListener(_ listener: AKMIDIListener) {
        midi.addListener(listener)
    }

    func getMIDIInputNames() -> [String] {
        return midi.inputNames
    }

    func openMIDIInput(byName: String) {
        midi.closeAllInputs()
        midi.openInput(name: byName)
    }

    func openMIDIInput(byIndex: Int) {
        midi.closeAllInputs()
        midi.openInput(name: midi.inputNames[byIndex])
    }

    func playNote(note: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
        AKLog("playNote \(note) \(velocity)")
        sampler.play(noteNumber: offsetNote(note, semitones: synthSemitoneOffset), velocity: velocity)
    }

    func stopNote(note: MIDINoteNumber, channel: MIDIChannel) {
        AKLog("stopNote \(note)")
        sampler.stop(noteNumber: offsetNote(note, semitones: synthSemitoneOffset))
    }

    func allNotesOff() {
        sampler.stopAllVoices()
    }

    func afterTouch(_ pressure: MIDIByte) {
    }

    func controller(_ controller: MIDIByte, value: MIDIByte) {
        switch controller {
        case AKMIDIControl.modulationWheel.rawValue:
            if sampler.filterEnable {
                sampler.filterCutoff = 1 + 19 * Double(value) / 127.0
            } else {
                sampler.vibratoDepth = 0.5 * Double(value) / 127.0
            }

        case AKMIDIControl.damperOnOff.rawValue:
            sampler.sustainPedal(pedalDown: value != 0)

        default:
            break
        }
    }

    func pitchBend(_ pitchWheelValue: MIDIWord) {
        let pwValue = Double(pitchWheelValue)
        let scale = (pwValue - 8_192.0) / 8_192.0
        if scale >= 0.0 {
            sampler.pitchBend = scale * self.pitchBendUpSemitones
        } else {
            sampler.pitchBend = scale * self.pitchBendDownSemitones
        }
    }

}

