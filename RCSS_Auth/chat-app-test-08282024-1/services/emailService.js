const nodemailer = require('nodemailer');
const { v4: uuidv4 } = require('uuid');
const { sequelize } = require('../db');

// 設置傳送信件的 transporter
const transporter = nodemailer.createTransport({
  service: 'Gmail',
  auth: {
    user: "dksms3003@gmail.com",
    pass: "phnjlkkujhpuesmd", // SMTP 授權碼
  },
});

// 生成6位隨機驗證碼
const generateVerificationCode = () => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};

// 發送驗證碼並儲存到資料庫
const sendVerificationCode = async (email) => {
  const code = generateVerificationCode();
  const expiresAt = new Date(Date.now() + 100 * 60 * 1000); // 設置100分鐘後過期

  try {
    
    await sequelize.query(
      `INSERT INTO verification_codes (id, email, code, expiresat, createdat, updatedat)
       VALUES (:id, :email, :code, :expiresAt, :createdAt, :updatedAt)`,
      {
        replacements: {
          id: uuidv4(),
          email,
          code,
          expiresAt,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        type: sequelize.QueryTypes.INSERT
      }
    );

    const mailOptions = {
      from: process.env.EMAIL_FROM,
      to: email,
      subject: '您的驗證碼',
      text: `您的驗證碼是 ${code}，該驗證碼將在10分鐘後過期。`
    };

    // 發送郵件
    await transporter.sendMail(mailOptions);
    console.log('信件發送成功');
  } catch (error) {
    console.error('發送驗證碼時出錯:', error);
    throw error;
  }
};

module.exports = {
  sendVerificationCode
};
