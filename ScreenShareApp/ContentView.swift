import SwiftUI

struct ContentView: View {
    @StateObject private var webRTCManager = WebRTCManager()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("iPhone Screen Share")
                .font(.largeTitle)
            
            if webRTCManager.isSharing {
                Text("Room ID: \(webRTCManager.roomId)")
                    .font(.title)
                    .foregroundColor(.blue)
                
                Button("Stop Sharing") {
                    webRTCManager.stopSharing()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            } else {
                Button("Start Screen Share") {
                    webRTCManager.startSharing()
                }
                .buttonStyle(.borderedProminent)
            }
            
            Text(webRTCManager.status)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
