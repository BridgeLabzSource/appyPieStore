import AVFoundation
import UIKit

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic()
    {
        let urlStr = Bundle.main.path(forResource: "background_music", ofType: "mp3")
        let url = URL(string: urlStr!)
    
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer!.numberOfLoops = -1
            audioPlayer?.volume = 3
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
}
