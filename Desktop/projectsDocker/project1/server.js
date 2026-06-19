const express = require('express');
const app = express();
 
const PORT = process.env.PORT || 3011;
 
app.get('/', (req, res) => {
  res.json({
    port: process.env.PORT,
    nodeEnv: process.env.NODE_ENV || null,
    appVersion: process.env.APP_VERSION || null,
    gitSha: process.env.GIT_SHA || null,
    buildDate: process.env.BUILD_DATE || null,
  });
});
 
app.listen(PORT, () => {
  console.log(`Сервер на http://localhost:${PORT}`);
});