const { response } = require('express');
const bcrypt = require('bcryptjs');
const User = require('../models/user');
const { generateJwt } = require('../helpers/jwt');

const createUser = async (req, res = response) => {
    const body = req.body;
    const { email, password } = body;
    try {
        const existingEmail = await User.findOne({ email });
        if (existingEmail) {
            return res.status(400).json({
                ok: false,
                msg: "Invalid email"
            });
        }

        const user = new User(body);
        const salt = bcrypt.genSaltSync();
        user.password = bcrypt.hashSync(password, salt);
        await user.save();
        const token = await generateJwt(user.id);

        return res.json({
            ok: true,
            user,
            token
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: "Internal server error"
        });
    }
}

const loginUser = async (req, res = response) => {
    const body = req.body;
    const { email, password } = body;
    try {
        const dbUser = await User.findOne({ email });
        if (!dbUser) {
            return res.status(404).json({
                ok: false,
                msg: "Invalid credentials"
            });
        }
        
        const validPassword = bcrypt.compareSync(password, dbUser.password);
        if (!validPassword) {
            return res.status(400).json({
                ok: false,
                msg: "Invalid credentials"
            });
        }

        const token = await generateJwt(dbUser.id);
        return res.json({
            ok: true,
            dbUser,
            token
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: "Internal server error"
        });
    }
}

const refreshToken = async (req, res = response) => {
    const uid = req.uid;
    const dbUser = await User.findById(uid);
    const token = await generateJwt(uid);

    return res.json({
        ok: true,
        dbUser,
        token
    });
}

module.exports = {
    createUser,
    loginUser,
    refreshToken
}
