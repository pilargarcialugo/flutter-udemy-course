const mongoose = require('mongoose');

const dbConn = async() => {
    try {
        await mongoose.connect(process.env.DB_URL);
        console.log('DB online');
    } catch (error) {
        console.log(error);
        throw new Error('Error in DB');
    }
}

module.exports = {
    dbConn
}
