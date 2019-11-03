const port = 8003;

var WebSocketServer = require('ws').Server,
    wss = new WebSocketServer({
        port: port
    });
wss.on('connection', function (ws) {
    console.log(`client connected, ${JSON.stringify(ws.readyState)}`);
    // ws.send(`connected success callback`);
    ws.on('message', function (message) {
        console.log(message);
        ws.send(`${message} callback`, (error) => {
            console.log(`111 error = ${error}`);
        });
    });

    ws.on('ping', function (message) {
        console.log('ping' + message);
        ws.send(`ping callback`);
    });

    ws.on('pong', function (message) {
        console.log('pong' + 'message');
        ws.send(`pong callback`);
    });

    ws.on('error', function (error) {
        console.log(`error connect, ${error},`);
        ws.send(`error ${error} callback`);
    });

    ws.on('close', function (code, reason) {
        console.log(`close connect, ${code}, ${reason}`);
        ws.send(`close connect callback`);
    });
});

console.log(`begin listen in port = ${port}`);