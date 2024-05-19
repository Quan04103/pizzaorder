const mongoose = require('mongoose')
const db = require('../config/db')

const { Schema } = mongoose

const userSchema = new Schema({
    username:{
        type: String,
        lowercase: true,
        required: true
    },
    password:{
        type: String,
    },
    nameProfile:{
        type: String,
        required: true,
        required: true
    },
    number:{
        type: String,
        required: true
    },
    address:{
        type: String,
        required: true,
    },
    email:{
        type: String,
        lowercase: true,
        required: true,
    },
})

const UserModel = db.model('user', userSchema);

module.exports = UserModel;