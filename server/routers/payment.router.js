const router = require('express').Router();
const PaymentController = require('../controller/payment.controller');
const authenticateJWT = require('../middleware/authenticationJwt');

router.post('/payment', PaymentController.createPayment);
router.post('/callback', PaymentController.callback);

module.exports = router;