import SwiftUI
import AudioKit

class Sequencer {
    let midi = AKMIDI()
    let sampler = AKSampler()
    var mixer = AKMixer()
    let oscBank = AKOscillatorBank(waveform: AKTable(AKTableType.positiveReverseSawtooth))//1
    let sequencer = AKAppleSequencer()
    var pos = 0.0
    init() {
        
        setup()
    }

    func setup() {
        let url = Bundle.main.url(forResource: "UprightPianoKW-20190703", withExtension: "sfz");        sampler.attackDuration = 0
        sampler.decayDuration = 0
        sampler.sustainLevel = 1
        sampler.releaseDuration = 2
       
        do{
            sampler.loadSFZ(url: url!)
            
        } catch{
            print("")
        }

        
       
        let midiNode = AKMIDINode(node: sampler)
        _ = sequencer.newTrack()
        sequencer.tracks[0].setMIDIOutput(midiNode.midiIn)
        

        let reverb = AKReverb(sampler)
        reverb.loadFactoryPreset(.plate)

        mixer = AKMixer(sampler, reverb, midiNode)
        AudioKit.output = mixer
        try? AudioKit.start()
    }

    func play() {
        sequencer.rewind()
        sequencer.play()
    }

    func stop() {
        sequencer.stop()
    }


    /// Generates some melody (Sweet Child of Mine)
    func generateSequence() {
        for _ in 0..<2 {
            sequencer.tracks[0].add(noteNumber: 64, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 62, velocity: 127, position: AKDuration(beats: 0.5), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 60, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 62, velocity: 127, position: AKDuration(beats: 1.5), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 64, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 64, velocity: 127, position: AKDuration(beats: 2.5), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 64, velocity: 127, position: AKDuration(beats: 4), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 62, velocity: 127, position: AKDuration(beats: 4.5), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 62, velocity: 127, position: AKDuration(beats: 5), duration: AKDuration(beats: 0.5))
        }
    }
    func addNote(note: UInt8) {
        sequencer.tracks[0].add(noteNumber: note, velocity: 127, position: AKDuration(beats: self.pos), duration: AKDuration(beats: 0.65) )
        self.pos += 0.9
    }


 
}
