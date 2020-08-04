const jwt = require('jsonwebtoken');
const config = require("./config");

const getToken = (user) => {
    return jwt.sign(
      {
        username: user.username,
        email: user.email,
      },
      config.JWT_SECRET,
      {
        expiresIn: '48h',
      }
    );
  };

module.exports = getToken;
