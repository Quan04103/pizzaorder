const paymentService = require('../services/payment.service');

async function createPayment(req, res) {
    const { app_user, amount } = req.body;
    try {
        const result = await paymentService.createPayment(app_user, amount);
        const callback = await paymentService.handleCallback(req.body.data, req.body.mac);
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
    }
}
function callback(req, res) {
    try {
        let dataStr = req.body.data;
        let reqMac = req.body.mac;

        let result = paymentService.handleCallback(dataStr, reqMac);

        res.json(result);
    } catch (ex) {
        console.log('lỗi:::' + ex.message);
        res.json({
            return_code: 0,
            return_message: ex.message,
        });
    }
}

module.exports = {
    createPayment,
    callback
};