const express = require('express');
const body_parser = require('body-parser')
const productRouter = require('./routers/product.router')
const userRouter = require('./routers/user.router')
const mongoose = require('mongoose');
const app = express();

app.use(body_parser.json());
app.use('/', userRouter);
app.use('/', productRouter);

module.exports = app;
