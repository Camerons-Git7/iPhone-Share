import Foundation
import WebRTC
import ReplayKit

class WebRTCManager: NSObject, ObservableObject {
    @Published var isSharing = false
    @Published var roomId = ""
    @Published var status = "Ready"
    
    private var peerConnection: RTCPeerConnection?
    private let factory = RTCPeerConnectionFactory()
    
    func generateRoomId() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map { _ in letters.randomElement()! })
    }
    
    func startSharing() {
        roomId = generateRoomId()
        status = "Initializing..."
        
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"])]
        
        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        peerConnection = factory.peerConnection(with: config, constraints: constraints, delegate: self)
        
        isSharing = true
        status = "Room: \(roomId) - Waiting for Chromebook..."
        
        showBroadcastPicker()
    }
    
    func stopSharing() {
        isSharing = false
        peerConnection?.close()
        status = "Stopped"
    }
    
    private func showBroadcastPicker() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let _ = windowScene.windows.first?.rootViewController {
                
                let pickerView = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                pickerView.preferredExtension = "com.yourapp.ScreenShareExtension"
                pickerView.showsMicrophoneButton = false
                
                for subview in pickerView.subviews {
                    if let button = subview as? UIButton {
                        button.sendActions(for: .touchUpInside)
                    }
                }
            }
        }
    }
}

extension WebRTCManager: RTCPeerConnectionDelegate {
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {}
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {}
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {}
}
