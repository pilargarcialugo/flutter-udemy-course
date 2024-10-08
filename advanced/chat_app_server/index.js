const express = require('express');
const path = require('path');
require('dotenv').config();

// Express App
const app = express();

// Sockets Node Server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/main-socket');

const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));

server.listen(process.env.PORT, (err) => {
    if (err) throw new Error(err);
    console.log('Servidor corriendo en puerto ', process.env.PORT);
});
