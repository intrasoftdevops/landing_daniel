const express = require('express');
const app = express();
const port = process.env.PORT || 8080;

app.use(express.static('public'));

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});

app.use((req, res) => {
  res.status(404).sendFile(__dirname + '/public/404.html');
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
}); 