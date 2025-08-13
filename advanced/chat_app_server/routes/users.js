/**
 * Path: api/users
 */
const { Router } = require('express');
const { validateToken } = require('../middlewares/jwt-validation');
const { getUsers } = require('../controllers/users');
const router = Router();

router.get('/', [
    validateToken
], getUsers);

module.exports = router;
