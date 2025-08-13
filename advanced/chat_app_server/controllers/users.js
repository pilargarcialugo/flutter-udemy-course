const { response } = require("express");
const User = require('../models/user');

const getUsers = async (req, res = response) => {
    const from = Number(req.query.from) || 0;

    const users = await User
        .find({_id: {$ne: req.uid}})  // Retrieves all users except the one making the request
        .sort('-online') // Sorts users based on whether they are online. Online users appear first
        .skip(from)
        .limit(20)

    return res.status(200).json({
        success: true,
        users
    });
}

module.exports = {
    getUsers,
}
