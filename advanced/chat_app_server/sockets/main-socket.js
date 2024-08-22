const {io} = require('../index')
const Options = require('../models/options');
const Option = require('../models/option');

const options = new Options(); 
options.addOption(new Option('Ten'));
options.addOption(new Option('Eleven'));
options.addOption(new Option('Twelve'));
options.addOption(new Option('Thirteen'));

// Sockets Messages
io.on('connection', client => {
    console.log('Cliente conectado');
    
    client.emit('available-options', options.getOptions());

    client.on('disconnect', () => {
        console.log('Cliente desconectado')
    });

    client.on('vote-option', (payload) => {
        options.voteOption(payload.id);

        // se usa io (que es el servidor) para que todos los clientes conectados se enteren:
        io.emit('available-options', options.getOptions()); 
    })

    client.on('add-option', (payload) => {
        options.addOption(new Option(payload.name));
        
        // se usa io (que es el servidor) para que todos los clientes conectados se enteren:
        io.emit('available-options', options.getOptions()); 
    })

    client.on('delete-option', (payload) => {
        options.deleteOption(payload.id);
        
        // se usa io (que es el servidor) para que todos los clientes conectados se enteren:
        io.emit('available-options', options.getOptions()); 
    })
})
