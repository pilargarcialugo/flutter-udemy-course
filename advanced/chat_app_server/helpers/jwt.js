const jwt = require('jsonwebtoken');

const generateJwt = (uid) => {
    return new Promise((resolve, reject) => {
        const payload = { uid };
        jwt.sign(
            payload, 
            process.env.JWT_KEY, 
            { expiresIn: '24h' }, 
            (err, token) => {
                if (err) {
                    reject('JWT generation failed');
                } else {
                    resolve(token);
                }
            }
        );
    });
}

const validateJwt = (token = '') => {
    try {
        const { uid } = jwt.verify(token, process.env.JWT_KEY);
        return [true, uid];
    } catch (error) {
        return [false, null];
    }
}

module.exports = {
    generateJwt,
    validateJwt
}
