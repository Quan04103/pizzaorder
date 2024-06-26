const UserModel = require('../model/user.model')
const jwt = require('jsonwebtoken');
// const nodemailer = require('nodemailer');
// const crypto = require('crypto');

class UserService {
    static async registerUser(username, password, nameProfile, number, address, email) {
        try {
            const createUser = new UserModel({ username, password, nameProfile, number, address, email });
            return await createUser.save();
        } catch (error) {
            throw new Error(error.message);
        }
    }
    static async checkUser(username) {
        try {
            return await UserModel.findOne({ username })
        } catch (error) {
            throw error;
        }
    }
    static async generateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
    }
    static async updateUser(userId, userData) {
        try {
            const updatedUser = await UserModel.findByIdAndUpdate(
                userId,
                { $set: userData },
                { new: true } // Trả về thông tin người dùng đã được cập nhật
            );
        } catch (error) {
            console.error('Error in updateUser service:', error);
            throw error;
        }
    }
}

module.exports = UserService;