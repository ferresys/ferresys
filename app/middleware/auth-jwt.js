const jwt = require('jsonwebtoken');
const express = require('express');
const app = express();

app.post('/login', (req, res) => {
  // Authenticate user
  // This is where you would query your database to find the user
  // For this example, we'll assume the user is { id: 1, username: 'test', password: 'test' }
  const user = { id: 1, username: 'test', password: 'test' };

  // Check if the username and password are correct
  // In a real application, never store passwords in plain text
  if (req.body.username === user.username && req.body.password === user.password) {
    // Create a token
    const token = jwt.sign({ id: user.id }, 'your-secret-key', { expiresIn: '1h' });

    // Send the token to the client
    res.json({ token });
  } else {
    res.status(401).send('Invalid username or password');
  }
});