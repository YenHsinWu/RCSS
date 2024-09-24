const express = require('express');
const router = express.Router();
const { sendVerificationCode } = require('../services/emailService'); 

// 驗證碼生成並發送
router.post('/send-verification-code', async (req, res) => {
  const { email } = req.body;

  try {
    await sendVerificationCode(email);
    res.json({ message: '驗證碼已發送到您的信箱' });
  } catch (error) {
    console.error(error.message);
    res.status(500).json({ error: '無法發送驗證碼' });
  }
});

module.exports = router;
