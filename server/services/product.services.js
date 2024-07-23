const ProductModel = require('../model/product.model')

class ProductService {
    static async getAllProduct() {
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

    static async getProductByCategory(categoryId) {
        try {
            const products = await ProductModel.find({ categoryId: categoryId });
            return products;
        } catch (error) {
            throw error.message;
        }
    }

    static async getProductById(id) {
        try {
            const products = await ProductModel.findById(id).exec();
            return products;
        } catch (error) {
            throw error.message;
        }
    }
}

module.exports = ProductService;