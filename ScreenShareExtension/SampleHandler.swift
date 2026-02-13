import ReplayKit

class SampleHandler: RPBroadcastSampleHandler {
    
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // User tapped "Start Broadcast"
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            // Send video frame to main app
            break
        case RPSampleBufferType.audioApp:
            break
        case RPSampleBufferType.audioMic:
            break
        @unknown default:
            break
        }
    }
    
    override func broadcastFinished() {
        // User stopped broadcast
    }
}
