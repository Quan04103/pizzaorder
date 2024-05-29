const express = require("express");
const mongoose = require("mongoose");
const mongooseConnection = require("./config/db");
const app = require('./app');
const cors = require('cors');
const UserModel = require('./model/user.model');
const ProductModel = require('./model/product.model')
const PORT = 5000;

app.use(cors());


app.get('/', (req, res) => {
  res.send("Hello world.....")
})

mongooseConnection.on("connected", () => {
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
});

mongooseConnection.on("error", (err) => {
  console.error("Failed to connect to MongoDB:", err);
});
