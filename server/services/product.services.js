const ProductModel = require('../model/product.model')

class ProductService {
    static async getProduct() {
        try {
            return await ProductModel.find()
        } catch (error) {
            throw error.message;
        }
    }
    static async getNewestProduct() {
        var today = new Date();
        var fiveDaysAgo = new Date(today);
        fiveDaysAgo.setDate(today.getDate() - 5);

        console.log('Five days ago:', fiveDaysAgo);
        console.log('Today:', today);

        try {
            return await ProductModel.find().where('dateadded').gte(fiveDaysAgo)
                .lte(today);
        } catch (error) {
            throw error.message;
        }
    }
}

module.exports = ProductService;