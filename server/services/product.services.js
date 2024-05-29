const ProductModel = require('../model/product.model')

class ProductService {
    static async getProduct() {
        try {
            return await ProductModel.find()
        } catch (error) {
            throw error.message;
        }
    }
}

module.exports = ProductService;