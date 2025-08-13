const User = require('../models/user');
const Message = require('../models/message');

const connectUser = async (uid = '') => {
    const user = await User.findById(uid);
    user.online = true;
    await user.save();
    return user;
}

const disconnectUser = async (uid = '') => {
    const user = await User.findById(uid);
    user.online = false;
    await user.save();
    return user;
}

const saveMessage = async(payload) => {
    /*
    payload:
    {
        from: '',
        to: '',
        message: ''
    }
    */
    try {
        const message = new Message(payload);
        await message.save();
        return false;
    } catch (error) {
        return false;
    }
}

module.exports = {
    connectUser,
    disconnectUser,
    saveMessage,
}
