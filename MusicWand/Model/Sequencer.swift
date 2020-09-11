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
//        let url = Bundle.main.url(forResource: "UprightPianoKW-20190703", withExtension: "sfz")!;
        let track = sequencer.newTrack()
        track?.setMIDIOutput(midicallback.midiIn)
        try? appleSampler.loadSoundFont("UprightPianoKW-20190703", preset: 0, bank: 0)
//        sampler.loadSFZ(url: url)
   
        //generate some notes and add them to the track
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
    
    
    func play() {

        sequencer.rewind()
        sequencer.play()
    }
    
    func stop() {
        sequencer.stop()
    }
    
    
    /// Generates some melody (Sweet Child of Mine)
    func generateSequence() {
            sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 74, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 77, velocity: 127, position: AKDuration(beats: 3), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 79, velocity: 127, position: AKDuration(beats: 4), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 81, velocity: 127, position: AKDuration(beats: 5), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 83, velocity: 127, position: AKDuration(beats: 6), duration: AKDuration(beats: 0.5))
            sequencer.tracks[0].add(noteNumber: 84, velocity: 127, position: AKDuration(beats: 7), duration: AKDuration(beats: 0.5))
    }
        func addNote(note: UInt8) {
            sequencer.tracks[0].add(noteNumber: note, velocity: 127, position: AKDuration(beats: self.pos), duration: AKDuration(beats: 0.65) )
            self.pos += 0.9
        }
    
    
    
}

