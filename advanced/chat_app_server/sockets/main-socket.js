const {io} = require('../index');
const {validateJwt} = require('../helpers/jwt');
const {connectUser, disconnectUser, saveMessage} = require('../controllers/socket')

io.on('connection', async (client) => {
    const [isValidToken, uid] = validateJwt(client.handshake.headers['x-token']);
    console.log('Cliente conectado:', isValidToken, uid);
    if (!isValidToken) {
        return client.disconnect();
    } 
    
    connectUser(uid);
    client.join(uid);

    client.on('personal-message', async (payload) => {
        console.log(payload);
        await saveMessage(payload);
        io.to(payload.to).emit('personal-message', payload);
    });

    client.on('disconnect', () => {
        disconnectUser(uid);
        console.log('Cliente desconectado:', isValidToken, uid)
    });
})
