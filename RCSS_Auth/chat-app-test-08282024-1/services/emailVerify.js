const { sequelize } = require('../db'); 
const { v4: uuidv4 } = require('uuid'); 

const verifyRegistration = async (email, code, user_name, phone, phone_country, password) => {
  try {
    
    console.log('Email:', email);
    console.log('Code:', code);
    console.log('User Name:', user_name);
    console.log('Phone:', phone);
    console.log('Phone Country:', phone_country);
    console.log('Password:', password);

    // 找出與提供的 email 和 code 匹配的記錄
    const records = await sequelize.query(
      `SELECT * FROM verification_codes WHERE email = :email AND code = :code`,
      {
        replacements: { email, code },
        type: sequelize.QueryTypes.SELECT
      }
    );

    // 打印查詢結果
    console.log('Records:', records);

    // 檢查查詢結果是否有返回記錄
    if (!records || records.length === 0) {
      throw new Error('驗證碼無效或已過期');
    }

    const record = records[0]; 

    if (!record || !record.expiresat) {
      throw new Error('無法讀取 expiresat 屬性，可能是資料表中沒有這個欄位或記錄不存在');
    }

    // 打印 expiresat 以進行調試
    console.log('Expires At:', record.expiresat);

    // 確認 expiresat 的時間格式
    const expiresAt = new Date(record.expiresat);
    const now = new Date();

    // 打印現在時間以進行調試
    console.log('Current Time:', now);

    // 檢查驗證碼是否過期
    if (now > expiresAt) {
      throw new Error('驗證碼已過期');
    }

    // 確認密碼存在且為有效字串
    if (!password || typeof password !== 'string') {
      throw new Error('密碼無效');
    }



    // 刪除已使用的驗證碼記錄
    await sequelize.query(
      `DELETE FROM verification_codes WHERE email = :email AND code = :code`,
      {
        replacements: { email, code }
      }
    );

    return { email };
  } catch (error) {
    console.error('Error in verifyRegistration:', error.message);
    throw error;
  }
};

module.exports = {
  verifyRegistration
};
