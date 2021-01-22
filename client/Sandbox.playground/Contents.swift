import Foundation
import SocketIO
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "http://localhost:8000")!
let manager = SocketManager(socketURL: url, config: [.log(true), .compress])
let socket = manager.defaultSocket

socket.on(clientEvent: .connect) { data, ack in
    print("✅ socket connected")
}
socket.on(clientEvent: .disconnect) { data, ack in
    print("🔴 socket disconnected")
}

socket.on("currentAmount") { data, ack in
    guard let currentAmount = data[0] as? Double else { return }

    print("📬 received amount: \(currentAmount)")
    socket.disconnect()
}

socket.connect()
