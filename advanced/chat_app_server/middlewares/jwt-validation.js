const jwt = require('jsonwebtoken');

const validateToken = (req, res, next) => {
    const token = req.header('x-token');
    if (!token) {
        res.status(401).json({
            ok: false,
            msg: 'Invalid token'
        });
    }

    try {
        const { uid } = jwt.verify(token, process.env.JWT_KEY);
        req.uid = uid;
        next();
    } catch (error) {
        res.status(401).json({
            ok: false,
            msg: 'Invalid token'
        });
    }
}

module.exports = {
    validateToken
}
