var express = require('express');
var fs = require('fs');
var http = require('http');
var bodyParser = require('body-parser');
var app = express();
app.use(bodyParser.json());

var defaultSocket = "/var/run/narhs/narhs.socket";
var count = 0;
var server = http.CreateServer(app);

app.post('/nic', (req, res)=>{

    var nino = req.body.nino;

    var number = nino.substr(4,6);

    number = parseInt(number);
    if (number > 50) {
        number = 50;
    }

    res.status(200).json({
        years: number
    }).end();

});

app.get('/meta/health', (req,res) => {
    res.status(200).end();
});

server.on('listening', () => {
    fs.chmodSync(defaultSocket, '777');
});

server.listen(defaultSocket, () => {
    
});
