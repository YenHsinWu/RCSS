require('dotenv').config();
const { Sequelize } = require('sequelize');

// 創建 Sequelize 實例
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
    host: process.env.DB_HOST,
    dialect: 'postgres',
    logging: console.log,  // 如果你希望看到 SQL 查詢，將此設為 true
});

// 測試連接
const testConnection = async () => {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
};

testConnection();

module.exports = { sequelize };
