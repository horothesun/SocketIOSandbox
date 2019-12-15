const io = require('socket.io')()
const server = require('http').createServer()

io.attach(server, {
  pingInterval: 10000,
  pingTimeout: 5000,
  cookie: false
})

io.on('connect', function(socket) {
    console.log(`Connected on ${socket.id}`)
    socket.emit("currentAmount", 123)
})

server.listen(8000)
