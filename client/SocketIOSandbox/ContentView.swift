import SwiftUI
import SocketIO

struct ContentView: View {

    static let url = URL(string: "http://localhost:8000")!
    let manager = SocketManager(socketURL: Self.url, config: [.log(true), .compress])
    let socket: SocketIOClient

    init() {
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { data, ack in
            print("✅ socket connected")
        }
        socket.on(clientEvent: .disconnect) { data, ack in
            print("🔴 socket disconnected")
        }
        socket.on("currentAmount") { [self] data, ack in
            guard let currentAmount = data[0] as? Double else { return }

            print("📬 received amount: \(currentAmount)")
            self.socket.disconnect()
        }
    }

    var body: some View {
        Button("Connect") {
            socket.connect()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
