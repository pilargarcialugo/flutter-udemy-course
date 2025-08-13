const Message = require('../models/message')

const retrieveMessages = async (req, res) => {
    const myId = req.uid;
    const messagesFrom = req.params.from;

    const lastMessages = await Message.find({
        $or: [{from: myId, to: messagesFrom}, {from: messagesFrom, to: myId}]
    })
    .sort({createdAt: 'desc'}) // Messages sorted ascendingly by creation date
    .limit(30); // Last 30 messages

    res.json({
        ok: true,
        lastMessages: lastMessages
    });
}

module.exports = {
    retrieveMessages,
}
