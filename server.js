var http = require('http');
var querystring = require('querystring');
var url = require('url');
var mongoose = require('mongoose');
var MongoClient = require('mongodb').MongoClient;
var dbo;

var server = http.createServer().listen(8080);

server.on('request', function (req, res) {
    var jsonObj = "abc";
    var body;
    var post;

    if (req.method == 'POST') {
        body = '';
    }

    req.on('data', function (data) {
        body += data;
    });

    req.on('end', function () {
        //console.log("Body is: " + body);
        post = querystring.parse(body);
        jsonObj = JSON.parse(body);
        //console.log("inside :" + jsonObj.mode);
        res.setHeader('Content-Type', 'application/json');

        MongoClient.connect("mongodb://localhost:27017/mydb", function(err, db) {
            if (err) throw err;
            dbo = db.db("Klothe");

            if(jsonObj.mode === "create") {
                delete jsonObj["mode"];
                dbo.createCollection("Clothing", function(err, res) {
                if (err) throw err;     
                dbo.collection("Clothing").insertOne(jsonObj, function(err, result) {
                    if (err) throw err;
                    db.close();
                    });
                });
                res.end(JSON.stringify(jsonObj));
            }
            else if(jsonObj.mode === "delete") {
                dbo.collection("Clothing").deleteOne(myquery, function(err, obj) {
                    if (err) throw err;
                    console.log("1 document deleted");
                    db.close();
                });
            }
            else if (jsonObj.mode === "getall") {
                dbo.collection("Clothing").find({}).toArray(function(err, result) {
                    if (err) throw err;
                    console.log(result);
                    res.end(JSON.stringify(result));
                });

            }
            /* print all to console
            console.log("Now printing all:\n");
            dbo.collection("Clothing").find({}).toArray(function(err, result) {
                if (err) throw err;
                console.log(result);
            });*/

       
        });

    });

});

/*http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/html'});
    var u  = url.parse(req.url, true).query;
    res.write(" " + u.first);
    var mode = u.mode;

    MongoClient.connect("mongodb://localhost:27017/mydb", function(err, db) {
  	if (err) throw err;
        var dbo = db.db("mydb");
        dbo.createCollection("Clothing", function(err, res) {
        if (err) throw err; 	
        console.log("Collection created!");

        dbo.collection("Clothing").insertOne(u, function(err, res) {
            if (err) throw err;
            console.log("1 item inserted");
            db.close();
        });

        var query = { last: "finkB" };

        dbo.collection("Clothing").find({}).toArray(function(err, result) {
            if (err) throw err;
            console.log(result);
         });


        db.close();

        });
    });


}).listen(8080); */

/*function add_to_database(jsonObj) {
        dbo.createCollection("Clothing", function(err, res) {
        if (err) throw err;     
        console.log("Collection created!");

        dbo.collection("Clothing").insertOne(jsonObj, function(err, res) {
            if (err) throw err;
            console.log("1 item inserted");
            db.close();
        });
    });
}*/
/*function print_all() {
    dbo.collection("Clothing").find({}).toArray(function(err, result) {
        if (err) throw err;
        console.log(result);
    });
}*/