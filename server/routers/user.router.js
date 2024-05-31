const router = require('express').Router();
const UserController = require('../controller/user.controller');
const authenticateJWT = require('../middleware/authenticationJwt');
const ProductController = require('../controller/product.controller');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
<<<<<<< HEAD
router.get('/getUserInfo', authenticateJWT, UserController.getUserInfo);
router.get('/getProduct', ProductController.getProduct);

=======
>>>>>>> ca086a72241af67e7e0802b0b3fc697a1cf12ecc
module.exports = router;