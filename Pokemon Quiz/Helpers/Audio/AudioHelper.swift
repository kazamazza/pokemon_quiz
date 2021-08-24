import Foundation
import AVKit

enum AudioError: Error {
    case fileNotFound
}

class AudioHelper: NSObject {
    
    static let shared = AudioHelper()
    private override init() {}
    var audioPlayers = [AVAudioPlayer]()
    
    func playTrack(name: String, loops: Int = 0) throws {
        guard let soundFileURL = Bundle.main.url(
            forResource: name, withExtension: "mp3"
        ) else {
            throw AudioError.fileNotFound
        }
        let existing = audioPlayers.filter { $0.url == soundFileURL}
        if existing.count > 0 {
            _ = existing.first?.play()
        } else {
        var audioPlayer: AVAudioPlayer!
        audioPlayer = try! AVAudioPlayer(contentsOf: soundFileURL)
        audioPlayer.numberOfLoops = loops
        audioPlayers.append(audioPlayer)
        guard let player = audioPlayers.last else {return}
        player.play()
        }
    }
}
