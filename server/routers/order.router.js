const router = require('express').Router();
const OrderController = require('../controller/order.controller');
const authenticateJWT = require('../middleware/authenticationJwt');

router.post('/addorder', authenticateJWT, OrderController.addOrder);
router.get('/user_orders/:iduser', authenticateJWT, OrderController.getOrderByUserId);

module.exports = router;