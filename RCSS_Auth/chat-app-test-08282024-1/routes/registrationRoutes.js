const express = require('express');
const router = express.Router();
const { verifyRegistration } = require('../services/emailVerify');

router.post('/verify-registration', async (req, res) => {
  const { email, code, user_name, phone, phone_country, password } = req.body;

  try {

    if (!email || !code || !user_name || !phone || !phone_country || !password) {
      return res.status(400).json({ error: '所有字段都是必需的' });
    }

    
    const user = await verifyRegistration(email, code, user_name, phone, phone_country, password);
    res.status(200).json({ message: '註冊成功', user });
  } catch (error) {
    
    console.error('Error in registration:', error.message);
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
