/**
 * Path: api/messages
 */
const { Router } = require('express');
const { validateToken } = require('../middlewares/jwt-validation');
const { retrieveMessages } = require('../controllers/messages');
const router = Router();

router.get('/:from', [
    validateToken
], retrieveMessages);

module.exports = router;
