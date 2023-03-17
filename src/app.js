// node server with sqlite3

const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const urlencodedParser = bodyParser.urlencoded({ extended: false });
const app = express();
const dbpath = './db/bata.db';
const port = process.env.PORT || 3000;
const hostname = 'localhost';

app.use(express.static('./'));

app.use(express.json());

// send x y z data to database
app.post('/senddata', urlencodedParser, function(req, res) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    let db = new sqlite3.Database(dbpath, sqlite3.OPEN_READWRITE, (err) => {
        if (err) {
            console.error(err.message);
        }
        console.log('Connected to the bata database.');
    });

    let sql = `INSERT INTO movement (x, y, z) VALUES (${req.body.x}, ${req.body.y}, ${req.body.z})`;

    db.run(sql, function(err) {
        if (err) {
            return console.log(err.message);
        }
        console.log(`A row has been inserted with rowid ${this.lastID}`);
    });

    db.close((err) => {
        if (err) {
            console.error(err.message);
        }
        console.log('Close the database connection.');
    });

    res.send('Data received');
});

// get data from database
app.get('/getdata', function(req, res) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    let db = new sqlite3.Database(dbpath, sqlite3.OPEN_READWRITE, (err) => {
        if (err) {
            console.error(err.message);
        }
        console.log('Connected to the bata database.');
    });

    let sql = `SELECT * FROM movement`;

    db.all(sql, [], (err, rows) => {
        if (err) {
            throw err;
        }
        rows.forEach((row) => {
            console.log(row);
        });
        res.send(rows);
    });

    db.close((err) => {
        if (err) {
            console.error(err.message);
        }
        console.log('Close the database connection.');
    });
});

app.listen(port, hostname, function() {
    console.log('Server running at http://' + hostname + ':' + port + '/');
});