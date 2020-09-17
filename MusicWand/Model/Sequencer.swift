import AudioKit
class Conductor {
    
    static let shared = Conductor()
    var sampler: AKSampler
    var appleSampler: AKAppleSampler
    var sequencer: AKAppleSequencer
    var mixer: AKMixer
    var pos = 0.0
    init() {
        AKSettings.playbackWhileMuted = true
        sampler = AKSampler()
        appleSampler = AKAppleSampler()
        sequencer = AKAppleSequencer()
        mixer=AKMixer(appleSampler)
        
        let midicallback = AKMIDICallbackInstrument()
        let track = sequencer.newTrack()
        track?.setMIDIOutput(midicallback.midiIn)
        try? appleSampler.loadSoundFont("Sounds/UprightPianoKW-20190703", preset: 0, bank: 0)
        
        generateSequence()
        
        appleSampler >>> mixer
        AudioKit.output = mixer
        try? AudioKit.start()
        
        
        midicallback.callback = { status, note, vel in
            let status = AKMIDIStatus(byte: status)
            let type = status?.type
            if type == .noteOn {
            print("note on: \(note), vel: \(vel)")
                try? self.appleSampler.play(noteNumber: note, velocity: vel, channel: 0)}
            if type == .noteOff {
                try? self.appleSampler.stop(noteNumber: note, channel: 0)
            }
        
        }

    }
    
    func setTempo(_ tempo: Int){
        let tempoDouble = Double(tempo)
        sequencer.setTempo(tempoDouble)
    }
    
    func play() {
        sequencer.rewind()
        sequencer.play()
    }
    func toggleLoop(){
        sequencer.toggleLoop()
    }
    
    func stop() {
        sequencer.stop()
    }
    
    func clearSequence(){
        sequencer.tracks[0].clear()
    }
    func generateSequence() {
        
        
        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 0.6), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 1.2), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 1.8), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 2.4), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 3.0), duration: AKDuration(beats: 1))
        
        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 4.1), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 4.8), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 5.3), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 77, velocity: 127, position: AKDuration(beats: 5.9), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 6.5), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 7.1), duration: AKDuration(beats: 0.5))
        
        sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 7.7), duration: AKDuration(beats: 1))
        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 7.7), duration: AKDuration(beats: 1))
        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 8.8), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 9.4), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 10.0), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 10.6), duration: AKDuration(beats: 0.5))
        
        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 11.2), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 11.8), duration: AKDuration(beats: 0.5))
        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 12.4), duration: AKDuration(beats: 1))


        
//        for _ in 0..<2 {
//            sequencer.tracks[0].add(noteNumber: 62, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 74, velocity: 127, position: AKDuration(beats: 0.5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 67, velocity: 127, position: AKDuration(beats: 1.5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 79, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 2.5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 78, velocity: 127, position: AKDuration(beats: 3), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 3.5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 62, velocity: 127, position: AKDuration(beats: 4), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 74, velocity: 127, position: AKDuration(beats: 4.5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 67, velocity: 127, position: AKDuration(beats: 5.5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 79, velocity: 127, position: AKDuration(beats: 6), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 6.5), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 78, velocity: 127, position: AKDuration(beats: 7), duration: AKDuration(beats: 0.5))
//            sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 7.5), duration: AKDuration(beats: 0.5))
//        }

    }
        func addNote(note: UInt8) {
            sequencer.tracks[0].add(noteNumber: note, velocity: 127, position: AKDuration(beats: self.pos), duration: AKDuration(beats: 0.65) )
            self.pos += 0.9
        }
    
    
    
}

