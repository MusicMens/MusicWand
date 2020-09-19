import AudioKit

func offsetNote(_ note: MIDINoteNumber, semitones: Int) -> MIDINoteNumber {
    let nn = Int(note)
    return (MIDINoteNumber)(semitones + nn)
}

class Conductor {
    
    static let shared = Conductor()
    let midi = AKMIDI()
    var appleSampler: AKAppleSampler
    var sequencer: AKAppleSequencer
    var mixer: AKMixer
    var pos = 0.0
    var pitchBendUpSemitones = 2
    var pitchBendDownSemitones = 2
    var loopEnabled = false
    var synthSemitoneOffset = 0
    init() {
        AKSettings.playbackWhileMuted = true
        appleSampler = AKAppleSampler()
        sequencer = AKAppleSequencer()
        mixer=AKMixer(appleSampler)
        
        // MIDI Configure
        midi.createVirtualPorts()
        midi.openInput(name: "Session 1")
        midi.openOutput()
        
        // Session settings
        //AKAudioFile.cleanTempDirectory()
        AKSettings.bufferLength = .medium
        AKSettings.enableLogging = true
        
        
        let midicallback = AKMIDICallbackInstrument()
        let track = sequencer.newTrack()
        track?.setMIDIOutput(midicallback.midiIn)
        try? appleSampler.loadSoundFont("Sounds/UprightPianoKW-20190703", preset: 0, bank: 0)
        
        //        generateSequence()
        
        appleSampler >>> mixer
        AudioKit.output = mixer
        try? AudioKit.start()
        
        
        midicallback.callback = { status, note, vel in
            let status = AKMIDIStatus(byte: status)
            let type = status?.type
            if type == .noteOn {
                print("note on: \(note), vel: \(vel)")
                print(self.sequencer.currentPosition.beats, self.sequencer.tempo)
                print((self.sequencer.currentPosition.beats / self.sequencer.tempo) * 60)
                try? self.appleSampler.play(noteNumber: note, velocity: vel, channel: 0)}
            if type == .noteOff {
                try? self.appleSampler.stop(noteNumber: note, channel: 0)
            }
            
        }
        
    }
    
    func setTempo(_ tempo: Int){
        print(sequencer.tempo)
        let tempoDouble = Double(tempo)
        sequencer.setTempo(tempoDouble)
    }
    
    func playPause() {
        
        if !sequencer.isPlaying{
            sequencer.play()
        }
        else {
            sequencer.stop()
        }
    }
    func toggleLoop(){
        sequencer.toggleLoop()
        self.loopEnabled = !self.loopEnabled
    }
    func rewind(){
        sequencer.rewind()
    }
    func stop() {
        sequencer.stop()
    }
    func play(){
        sequencer.rewind()
        sequencer.play()
    }
    func clearSequence(){
        sequencer.tracks[0].clear()
    }
    //    func generateSequence() {
    //
    //
    //        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 0.6), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 1.2), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 1.8), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 2.4), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 3.0), duration: AKDuration(beats: 1))
    //
    //        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 4.1), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 4.8), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 5.3), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 77, velocity: 127, position: AKDuration(beats: 5.9), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 6.5), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 7.1), duration: AKDuration(beats: 0.5))
    //
    //        sequencer.tracks[0].add(noteNumber: 69, velocity: 127, position: AKDuration(beats: 7.7), duration: AKDuration(beats: 1))
    //        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 7.7), duration: AKDuration(beats: 1))
    //        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 8.8), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 76, velocity: 127, position: AKDuration(beats: 9.4), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 10.0), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 75, velocity: 127, position: AKDuration(beats: 10.6), duration: AKDuration(beats: 0.5))
    //
    //        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 11.2), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 72, velocity: 127, position: AKDuration(beats: 11.8), duration: AKDuration(beats: 0.5))
    //        sequencer.tracks[0].add(noteNumber: 71, velocity: 127, position: AKDuration(beats: 12.4), duration: AKDuration(beats: 1))
    //
    //
    
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
    //
    //    }
    func addNote(note: UInt8) {
        sequencer.tracks[0].add(noteNumber: note, velocity: 127, position: AKDuration(beats: self.pos), duration: AKDuration(beats: 0.65) )
        self.pos += 0.9
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
        try? appleSampler.play(noteNumber: offsetNote(note, semitones: synthSemitoneOffset), velocity: velocity)
    }
    
    func stopNote(note: MIDINoteNumber, channel: MIDIChannel) {
        AKLog("stopNote \(note)")
        try? appleSampler.stop(noteNumber: offsetNote(note, semitones: synthSemitoneOffset))
    }
    
}

