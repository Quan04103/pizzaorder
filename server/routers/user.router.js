const router = require('express').Router();
const UserController = require('../controller/user.controller');
const authenticateJWT = require('../middleware/authenticationJwt');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.get('/getUserInfo', authenticateJWT, UserController.getUserInfo);
router.put('/updateAddress', authenticateJWT, UserController.updateAddress);

module.exports = router;