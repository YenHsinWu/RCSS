const express = require('express');
const router = express.Router();
const { User } = require('../models'); 
const { v4: uuidv4 } = require('uuid');

// 新增用戶
router.post('/', async (req, res) => {
    const { user_name, email, phone, phone_country, password, role } = req.body;
    const uuid = uuidv4();
    try {
        const newUser = await User.create({
            user_name,
            email,
            phone,
            phone_country,
            password,
            role,
            uuid
        });
        res.json(newUser);
    } catch (err) {
        console.error(err.message);
        res.status(500).json({ error: "Database error" });
    }
});

// 查詢所有用戶
router.get('/', async (req, res) => {
    try {
        const users = await User.findAll();
        res.json(users);
    } catch (err) {
        console.error(err.message);
        res.status(500).json({ error: "Database error" });
    }
});

// 查詢用戶 id
router.get('/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const user = await User.findByPk(id);
        if (user) {
            res.json(user);
        } else {
            res.status(404).json({ error: "User not found" });
        }
    } catch (err) {
        console.error(err.message);
        res.status(500).json({ error: "Database error" });
    }
});

module.exports = router;
