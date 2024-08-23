/**
 * Path: api/login
 */
const { Router } = require('express');
const { check } = require('express-validator');
const { createUser, loginUser, refreshToken } = require('../controllers/auth');
const { validateFields } = require('../middlewares/fields-validation');
const { validateToken } = require('../middlewares/jwt-validation');
const router = Router();

router.post('/new', [
    check('name', 'name is required').not().isEmpty(),
    check('email', 'email is required').not().isEmpty(),
    check('email', 'email is invalid').isEmail(),
    check('password', 'password is required').not().isEmpty(),
    validateFields
], createUser);

router.post('/', [
    check('email', 'email is required').not().isEmpty(),
    check('email', 'email is invalid').isEmail(),
    check('password', 'password is required').not().isEmpty(),
    validateFields
], loginUser);

router.get('/token/refresh', [
    check('token', 'token is required').not().isEmpty(),
    validateToken
], refreshToken);

module.exports = router;
