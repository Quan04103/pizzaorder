const mongoose = require("mongoose");

// Kết nối MongoDB
const connection = mongoose.createConnection(
  "mongodb+srv://mongo:c7WJ1YCELaFJ3UUc@cluster0.uyr6yth.mongodb.net/pizza_order",
);

connection.on("connected", () => {
  console.log("MongoDB connected");
});

connection.on("error", (err) => {
  console.error("MongoDB connection error:", err);
  process.exit(1);
});


module.exports = connection;
