// This tests the basic functions of the DB2 extension. 
// --The testConn() tests the connection functions.
// --The testQurey() queries the built-in table QIWS.QCUSTCDT and returns the result as a JSON object.
// --The testServerMode() verifies the serverMode() API.
// --The testAutoCommit() verifies the autoCommit() API.
// --The testCursorType() verifies the cursorType() API.
// --The testEnvAttr() verifies the setEnvAttr()/getEnvAttr() API.
// --The testConnAttr() verifies the setConnAttr()/getConnAttr() API.
// --The testStmtAttr() verifies the setStmtAttr()/getStmtAttr() API.
// --The testSimpleSQL() creates a new table TEST.NAMEID and insert a row of record. Then queries the table and drop it.

 // var db = require('/home/rbrownpa/node-js/db2.js');
// var conf = require('config.js');
 var db = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/db2i/lib/db2');
  var xt = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/xstoolkit/lib/itoolkit');
 // var ip =  '66.186.183.119';
// var port = 80;
// var fs = require('fs');
// var url = require('url'); 
var DBname = "*LOCAL"; 

function testConn() {
	console.log("\n  testConn()\n----------------------------------");
	try{
		db.debug(true);
		db.init();
		db.conn(DBname);
		db.close();

		db.init();
		db.conn(DBname, function(){
			console.log("call back in db.conn().")
		});
		db.close();

		db.init();
		db.conn(DBname, 'RBROWNPA', 'I5E0CC8PW');
		db.close();

		db.init();
		db.conn(DBname, 'RBROWNPA', 'I5E0CC8PW', function(){
			console.log("call back in db.conn().")
		});
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n FAILED!!! testConn()\n----------------------------------");
		return -1;
	}
};

function testQurey() {
	console.log("\n  testQurey()\n----------------------------------");
	var rc = db.SQL_SUCCESS;
	try{
		db.debug(true);
		db.init();
		db.conn(DBname);
		db.exec("SELECT LSTNAM, STATE FROM QIWS.QCUSTCDT", 
			function(jsonObj) {
				console.log("Result: %s", JSON.stringify(jsonObj));
			}
		);
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!! testQurey()\n----------------------------------");
		return -1;
	}
};

function testServerMode() {
	console.log("\n  testServerMode()\n----------------------------------");
	var mode = true;
	try{
		db.debug(true);
		db.init( function(){
			db.serverMode(true);
			if(mode != db.serverMode()) {
				db.close();
				return -1;
			}
			mode = false;
			db.serverMode(mode);
			if(mode != db.serverMode()) {
				db.close();
				return -1;
			}
		});
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!! testServerMode()\n----------------------------------");
		return -1;
	}
} 

function testAutoCommit() {
	console.log("\n  testAutoCommit()\n----------------------------------");
	var mode = true;
	try{
		db.debug(true);
		db.init();	
		db.conn(DBname, function(){
			db.autoCommit(mode);
			if(mode != db.autoCommit()) {
				db.close();
				return -1;
			}
			mode = false;
			db.autoCommit(mode);
			if(mode != db.autoCommit()) {
				db.close();
				return -1;
			}
		});
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!! testAutoCommit()\n----------------------------------");
		return -1;
	}
} 

function testCursorType() {
	console.log("\n  testCursorType()\n----------------------------------");
	var mode = db.SQL_CURSOR_DYNAMIC;
	try{
		db.debug(true);
		db.init();
		db.conn(DBname);
		db.cursorType(mode);		
		if(mode != db.cursorType()) {
			db.close();
			return -1;
		}
		mode = db.SQL_CURSOR_FORWARD_ONLY;
		db.cursorType(mode);
		if(mode != db.cursorType()) {
			db.close();
			return -1;
		}
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!! testCursorType()\n----------------------------------");
		return -1;
	}
} 

function testEnvAttr() {
	console.log("\n  testEnvAttr()\n----------------------------------");
	var mode = db.SQL_TRUE;
	try{
		db.debug(true);
		db.init(function(){
			db.setEnvAttr(db.SQL_ATTR_ENVHNDL_COUNTER, mode);
			if(mode != db.getEnvAttr(db.SQL_ATTR_ENVHNDL_COUNTER)) {
				db.close();
				return -1;
			}
			mode = db.SQL_FALSE;
			db.setEnvAttr(db.SQL_ATTR_ENVHNDL_COUNTER, mode);
			if(mode != db.getEnvAttr(db.SQL_ATTR_ENVHNDL_COUNTER)) {
				db.close();
				return -1;
			}
		});
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!!! testEnvAttr()\n----------------------------------");
		return -1;
	}
} 

function testConnAttr() {
	console.log("\n  testConnAttr()\n----------------------------------");
	var mode = "QSYS2";
	try{
		db.debug(true);
		db.init();	
		db.conn(DBname, function(){
			db.setConnAttr(db.SQL_ATTR_DBC_DEFAULT_LIB , mode);
			if(mode != db.getConnAttr(db.SQL_ATTR_DBC_DEFAULT_LIB )) {
				db.close();
				return -1;
			}
		});
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!! testConnAttr()\n----------------------------------");
		return -1;
	}
} 

function testStmtAttr() {
	console.log("\n  testStmtAttr()\n----------------------------------");
	var mode = db.SQL_TRUE;
	try{
		db.debug(true);
		db.init();
		db.conn(DBname);
		db.setStmtAttr(db.SQL_ATTR_FOR_FETCH_ONLY, mode);		
		if(mode != db.getStmtAttr(db.SQL_ATTR_FOR_FETCH_ONLY)) {
			db.close();
			return -1;
		}
		mode = db.SQL_FALSE;
		db.setStmtAttr(db.SQL_ATTR_FOR_FETCH_ONLY, mode);		
		if(mode != db.getStmtAttr(db.SQL_ATTR_FOR_FETCH_ONLY)) {
			db.close();
			return -1;
		}
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!! testStmtAttr()\n----------------------------------");
		return -1;
	}
} 

function testSimpleSQL() {
	console.log("\n  testSimpleSQL()\n----------------------------------");
	try{
		db.debug(true);
		db.init(function(){
			db.serverMode(true);
		});
		db.conn(DBname, 'RBROWNPA', 'I5E0CC8PW', function(){
			db.autoCommit(true);
		});
		


		db.exec("SELECT * FROM qsys2.LIBRARY_LIST_INFO", 
			function(jsonObj) {
				console.log("Result: %s", JSON.stringify(jsonObj));
				var fieldNum = db.numFields();
				console.log("There are %d fields in each row.", fieldNum);
				console.log("Name | Length | Type | Precise | Scale | Null");
				for(var i = 0; i < fieldNum; i++)
					console.log("%s | %d | %d | %d | %d | %d", db.fieldName(i), db.fieldWidth(i), db.fieldType(i), db.fieldPrecise(i), db.fieldScale(i), db.fieldNullable(i));
			}
		);
		 
		db.close();
		return 0;
	} catch(e) {
		console.log(e);
		console.log("\n  FAILED!!! testSimpleSQL()\n----------------------------------");
		return -1;
	}
};

testConn();
testQurey();
testServerMode();
testAutoCommit();
testCursorType();
testEnvAttr();
testConnAttr();
testStmtAttr();
testSimpleSQL();

var xt = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/xstoolkit/lib/itoolkit');
var conn = new xt.iConn('*LOCAL', 'RBROWNPA', 'I5E0CC8PW');
conn.add(xt.iCmd('RTVJOBA USRLIBL(?) SYSLIBL(?)'));
function cbJson(str) {
    console.log('The raw XML output --- ');
    console.log(str);  // Print the raw XML output
    console.log('The formatted JSON output --- ');
    console.log(JSON.stringify(xt.xmlToJson(str), null, 4));  // Print the formatted JSON output
}
conn.run(cbJson);


var xt = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/xstoolkit/lib/itoolkit');
var conn = new xt.iConn('*LOCAL', 'RBROWNPA', 'I5E0CC8PW');
var sql = new xt.iSql();
sql.prepare("call qsys2.NETSTAT_INFO");
sql.execute();
sql.fetch();
sql.free();
conn.add(sql);
function cb(str) {
	console.log(JSON.stringify(xt.xmlToJson(str), null, 4));
	//console.log(JSON.stringify(xt.xmlToJson(str));
	}
conn.run(cb);

