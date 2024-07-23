const UserService = require('../services/user.services')
const jwt = require('jsonwebtoken');

require('dotenv').config();

exports.updateAddress = async (req, res, next) => {
    try {
        const { iduser, newAddress } = req.body; // Lấy địa chỉ mới từ body của request
        const updatedUser = await UserService.updateUserAddress(iduser, newAddress);
        if (!updatedUser) {
            throw new Error('User not found');
        }
        let tokenData = { _id: updatedUser._id, username: updatedUser.username, nameProfile: updatedUser.nameProfile, address: updatedUser.address };
        const newToken = await UserService.generateToken(tokenData, process.env.SECRET_KEY, '1h');
        res.json({ status: true, success: "Address updated successfully", user: updatedUser, token: newToken });
    } catch (error) {
        next(error);
    }
};

exports.register = async (req, res, next) => {
    try {
        const { username, password, nameProfile, number, address, email } = req.body;

        const successRes = await UserService.registerUser(username, password, nameProfile, number, address, email)

        res.json({ status: true, success: "User registered successfully" });
    } catch (error) {
        next(error);
    }
}

exports.login = async (req, res, next) => {
    try {
        const { username, password } = req.body;

        const user = await UserService.checkUser(username);
        if (!user) {
            throw new Error('User not exist');
        }
        const isMatch = await user.comparePassword(password);
        if (isMatch === false) {
            throw new Error('Password invalid');
        }

        let tokenData = { _id: user._id, username: user.username, nameProfile: user.nameProfile, address: user.address };
        const token = await UserService.generateToken(tokenData, process.env.SECRET_KEY, '1h');
        res.status(200).json({ status: true, token: token, success: "User login successfully", user });
    } catch (error) {
        next(error);
    }
}

exports.getUserInfo = async (req, res, next) => {
    try {
        const { username } = req.user;
        const user = await UserService.checkUser(username);
        if (!user) {
            throw new Error('User not found');
        }
        res.json(user);
    } catch (error) {
        next(error);
    }
};

exports.editUser = async (req, res) => {
    try {
        const userId = req.userId; // Lấy userId từ decoded token trong middleware authenticateJWT
        const { username, nameProfile, number, address, email } = req.body;

        // Gọi service để cập nhật thông tin người dùng
        const updatedUser = await UserService.updateUser(userId, { username, nameProfile, number, address, email });

        // Trả về thông tin người dùng đã được cập nhật dưới dạng JSON response
        res.status(200).json(updatedUser);
    } catch (error) {
        console.error('Error editing user information:', error);
        if (error.message === 'User not found') {
            return res.status(404).json({ message: 'User not found' });
        }
        res.status(500).json({ message: 'Internal server error' });
    }
};