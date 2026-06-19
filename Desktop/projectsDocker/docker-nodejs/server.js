const express = require('express');
const app = express();
const port = 5555;
 
app.get('/', (req, res) => {
  res.send('Привет от Express!');
});
 
app.listen(port, () => {
  console.log(`Сервер запущен: http://localhost:${port}`);
});