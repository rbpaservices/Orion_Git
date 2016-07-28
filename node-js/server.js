var http = require('http');
var db = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/db2i/lib/db2');
var xt = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/xstoolkit/lib/itoolkit');
// var ip =  '66.186.183.119';
var ip = '192.168.0.2';
var port = (process.env.PORT || 3000);
var fs = require('fs');
var url = require('url'); 
var DBname = '*LOCAL';
var mode = 'QSYS2';

var webserver =	http.createServer(function (req, res) { 
	var realPath = __dirname + url.parse(req.url).pathname;
	
	console.log('Real Path: ' + realPath);
	
	 fs.exists(realPath, function(exists){ 
		 if(!exists){ 
			 var sql = url.parse(req.url, true).query.sql;
			 	var cl = url.parse(req.url, true).query.cl;
					res.writeHead(200, {'Content-Type': 'text/plain'}); 
					if(sql && sql.length > 0) { 
						//db.init();
						db.init(function(){				
							db.serverMode(true); //Enable Server Mode if needed
						});
						
						 db.conn('*LOCAL', function(){

			                  db.setConnAttr(db.SQL_ATTR_DBC_DEFAULT_LIB , mode);

			                  if(mode != db.getConnAttr(db.SQL_ATTR_DBC_DEFAULT_LIB )) {

			                         db.close();

			console.log('Failed to set Connection Attribute.');
			                  }else{
			                	  console.log('Connection Attribute set: ' + mode)
			                  

			                  }

			           });
						
						
						//db.conn(DBname);  // Connect to the DB 
						db.exec(sql, function(rs) {	  // Query the statement 
							res.write(JSON.stringify(rs)); 
						}); 
					db.close(); 
				} 
					if(cl && cl.length > 0)
					{
						// console.log("CL statement : " + cl); 
						var	conn = new xt.iConn(DBname);
						conn.add(xt.iSh("system -i " + cl)); 
						function cb(str) {
						res.write(xt.xmlToJson(str)[0].data);
						} 
						conn.run(cb); 
					} 
	res.end();
				res.end(); 
			 } else { 
				 var file = fs.createReadStream(realPath); 
				 res.writeHead(200, {'Content-Type': 'text/html'}); 
				 file.on('data', res.write.bind(res)); 
				 file.on('close', res.end.bind(res));  
				 file.on('error', function(err){ 
					 res.writeHead(500, {'Content-Type': 'text/plain'}); 
					 res.end("500 Internal Server Error"); 
				 }); 
			 }
	});
});

webserver.listen(port, ip);
 
console.log('Server running at http://'
		+ ip +':' + port  );
