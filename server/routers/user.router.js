const router = require('express').Router();
const UserController = require('../controller/user.controller');
const authenticateJWT = require('../middleware/authenticationJwt');
const ProductController = require('../controller/product.controller');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.get('/getUserInfo', authenticateJWT, UserController.getUserInfo);
router.put('/editUser', authenticateJWT, UserController.editUser);
module.exports = router;