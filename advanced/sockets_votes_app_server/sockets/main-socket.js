const {io} = require('../index')

// Sockets Messages
io.on('connection', client => {
    console.log('Cliente conectado');
    
    client.on('disconnect', () => {
        console.log('Cliente desconectado')
    });

    client.on('message', (payload) => {
        console.log('Message arrived!', payload);

        io.emit('response', {admin: 'Respuesta del msg'});
    });
})
