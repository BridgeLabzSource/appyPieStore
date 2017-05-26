import AVFoundation
import UIKit

class AudioPlayerHelper {
    static let sharedHelper = AudioPlayerHelper()
    var audioPlayer: AVPlayer?
//    var audioModel:AudioListingModel!
//    func replaceAudio(playerModel:AudioListingModel)
//    {
//        let url = URL(string: playerModel.downloadUrl)
//        
//        do{
//            audioPlayer =  AVPlayer(url: url!)
//            audioPlayer?.volume = 3
//        }
//    }
//
//    func play() {
//        if audioPlayer?.currentItem != nil {
//            MusicHelper.sharedHelper.audioPlayer?.pause()
//            audioPlayer!.play()
//       
//        } else {
//            if audioModel != nil {
//                replaceAudio(playerModel: audioModel)
//            }
//        }
//    }
//    
//    func pause() {
//        audioPlayer?.pause()
//        MusicHelper.sharedHelper.audioPlayer?.play()
//    }
    
//    func stopCurrentAudio(){
//        audioPlayer?.pause()
//        audioPlayer?.currentItem?.cancelPendingSeeks()
//        audioPlayer?.currentItem?.asset.cancelLoading()
//        audioPlayer?.replaceCurrentItem(with: nil)
//    }
        
}
