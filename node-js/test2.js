// TEST various SQL Statements
 var db = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/db2i/lib/db2');
 var config = require('./config');
//  var xt = require('/QOpenSys/QIBM/ProdData/OPS/Node4/os400/xstoolkit/lib/itoolkit');

var DBname = "*LOCAL";
var myIP = "24.115.110.36";
var  selectVar;
// selectVar = "'QEZJOBLOG'";
// selectVar = "'LOADED'";
// selectVar = "'V7R2M0'";
selectVar = "'%MAX%'";


// (FAILED 'QEZJOBLOG')  var sqlSTM = String('SELECT * FROM QSYS2.OUTPUT_QUEUE_ENTRIES WHERE OUTPUT_QUEUE_NAME = ' + selectVar + ' FETCH FIRST 10 ROWS ONLY');

//  (WORKS) var sqlSTM = String('SELECT * FROM QSYS2.NETSTAT_ROUTE_INFO')

//(WORKS 'LOADED') var sqlSTM = String('SELECT PTF_IDENTIFIER, PTF_IPL_REQUIRED, A.* FROM QSYS2.PTF_INFO A WHERE PTF_LOADED_STATUS = ' + selectVar + ' ORDER BY PTF_PRODUCT_ID'); 

//(WORKS 'NONE') var sqlSTM = String('SELECT PTF_IDENTIFIER, PTF_IPL_REQUIRED, A.* FROM QSYS2.PTF_INFO A WHERE PTF_IPL_ACTION <>  ' + selectVar + ' ORDER BY PTF_PRODUCT_ID'); 

// (WORKS 'V7R2M0') var sqlSTM = String('SELECT PTF_IDENTIFIER, PTF_IPL_REQUIRED, A.* FROM QSYS2.PTF_INFO A WHERE PTF_RELEASE_LEVEL =  ' + selectVar + ' ORDER BY PTF_PRODUCT_ID'); 

// (FAILED) var sqlSTM = String('SELECT * FROM QSYS2.LIBRARY_LIST_INFO');

var sqlSTM = String('SELECT * FROM QSYS2.SYSTEM_VALUE_INFO WHERE SYSTEM_VALUE_NAME LIKE ' + selectVar);

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
		


	 
		db.exec(sqlSTM , 
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



testSimpleSQL();

