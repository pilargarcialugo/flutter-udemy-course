const {io} = require('../index')

// Sockets Messages
io.on('connection', client => {
    console.log('Cliente conectado');
    
    client.on('disconnect', () => {
        console.log('Cliente desconectado')
    });
})
