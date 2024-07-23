const OrderService = require('../services/order.service');
require('dotenv').config();

exports.addOrder = async (req, res, next) => {
    try {
        const { iduser, listorder, price, dateadded } = req.body;
        const order = await OrderService.addOrder(iduser, listorder, price, dateadded);
        res.status(200).json({ status: true, success: "Add order success", order });
    } catch (error) {
        next(error);
    }
};

exports.getOrderByUserId = async (req, res, next) => {
    try {
        const { iduser } = req.params;
        const orders = await OrderService.getOrderByUserId(iduser);
        if (!orders) {
            throw new Error('No orders found for this user');
        }
        res.status(200).json(orders);
    } catch (error) {
        next(error);
    }
};

