const UserService = require('../services/user.services')
const jwt = require('jsonwebtoken');

require('dotenv').config();

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

        let tokenData = { _id: user._id, username: user.username };
        const token = await UserService.generateToken(tokenData, process.env.SECRET_KEY, '1h');
        res.status(200).json({ status: true, token: token, success: "User login successfully", user});
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