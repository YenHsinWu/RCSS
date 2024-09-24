require('dotenv').config();
const { Sequelize } = require('sequelize');
const User = require('./models/user');  // 引入你的模型

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
    host: process.env.DB_HOST,
    dialect: 'postgres',
    logging: console.log,  // 關閉 SQL 查詢日誌
});

describe('User Model Test', () => {
    beforeAll(async () => {
        await sequelize.authenticate();
        await sequelize.sync({ force: true }); // 確保資料表存在並重建
    });

    afterAll(async () => {
        await sequelize.close();
    });

    test('should create a new user', async () => {
        const user = await User.create({
            uuid: 'some-uuid',
            user_name: 'testuser',
            email: 'testuser@example.com',
            phone: '1234567890',
            phone_country: 'US',
            password: 'password',
            role: 'user',
        });

        expect(user).toHaveProperty('id');
        expect(user.user_name).toBe('testuser');
    });

    test('should find all users', async () => {
        await User.create({
            uuid: 'another-uuid',
            user_name: 'anotheruser',
            email: 'anotheruser@example.com',
            phone: '0987654321',
            phone_country: 'US',
            password: 'password',
            role: 'user',
        });

        const users = await User.findAll();
        expect(users.length).toBeGreaterThan(0);
    });
});
