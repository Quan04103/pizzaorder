const express = require('express');
const body_parser = require('body-parser')
const productRouter = require('./routers/product.router')
const userRouter = require('./routers/user.router')
const orderRouter = require('./routers/order.router');
const searchRouter = require('./routers/search.router');
const paymentRouter = require('./routers/payment.router');
const mongoose = require('mongoose');
const app = express();

app.use(body_parser.json());
app.use('/', userRouter);
app.use('/', productRouter);
app.use('/', orderRouter);
app.use('/', searchRouter);
app.use('/', paymentRouter);

module.exports = app;