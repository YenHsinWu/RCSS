require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const User = require('./models/user');  // 引入 User 模型

// 引入路由模組
const verificationRoutes = require('./routes/verificationRoutes'); // 新增部分
const userRoutes = require('./routes/userRoutes'); // 新增部分


// 使用正確的路由模組
const registrationRoutes = require('./routes/registrationRoutes');







const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());

// 使用 userRoutes 路由模組
app.use('/api/users', userRoutes); // 新增部分

// 使用 verificationRoutes 路由模組
app.use('/api/verification', verificationRoutes); // 新增部分



/////////////////////////////////////
app.use('/api', registrationRoutes);// 新增部分測試


// 使用路由模組
app.use('/api/verify-registration', registrationRoutes); // 設置路由

app.use('/api/verify-registration', (req, res, next) => {
  console.log('Received request at /api/verify-registration');
  next();
}, verificationRoutes);//除錯測試

/////////////////////////////////////

// 根路徑測試
app.get('/', (req, res) => {
  res.send('Hello, Chat App!');
});

// 測試
app.get("/test", (req, res) => {
  res.json({
      result: 'ok'
  });
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
