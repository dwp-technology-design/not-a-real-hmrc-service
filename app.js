var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(bodyParser.json());

var count = 0;

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

app.listen(8080, () => {
    
});
