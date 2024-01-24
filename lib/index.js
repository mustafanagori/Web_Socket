const express = require('express');
const { createServer } = require('http');  // Changed to createServer
const { Server } = require('ws');

const PORT = process.env.PORT || 3000;

// Changed variable name from 'server' to 'expressServer'
const server = express().use((req, res) => res.send("hello world")).listen(PORT, () => console.log("Listening " , PORT));

const wss = new Server({server});

wss.on('connection', ws => {
    console.log('client connected');
    ws.on('message', message => console.log(`Received: ${message}`));  // Fixed the template string
    ws.on('close', () => console.log('client disconnected'));  // Fixed typo 'discounted' to 'disconnected'
});
