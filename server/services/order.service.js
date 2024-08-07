const OrderModel = require('../model/order.model')

class OrderService {
    static async addOrder(iduser, listorder, price, dateadded) {
        try {
            const createOrder = new OrderModel({ iduser, listorder, price, dateadded });
            return await createOrder.save();
        } catch (error) {
            throw error.message;
        }
    }

    static async getOrderByUserId(iduser) {
        try {
            return await OrderModel.find({ iduser });
        } catch (error) {
            throw error.message;
        }
    }
}

module.exports = OrderService;