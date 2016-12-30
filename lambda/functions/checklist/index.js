var mysql      = require('mysql');

exports.handle = function(e, ctx, cb) {
	var connection = mysql.createConnection({
	  host     : 'dbinstance1.c87ozxpxckrx.us-east-1.rds.amazonaws.com',
	  user     : 'admin',
	  password : 'admin123',
	  database : 'VehicleMaint'
	});
	connection.connect(function(err) {
	 	if (err) {
	 		cb('error connecting: ' + err.stack, null);
	  	}
	  	else {
	  		var queryStr = "select c.checkListId, c.checkListDesc, c.frequency from model_checkList mc  join checkList c on (mc.checkListId = c.checkListId) where mc.modelLineCode = (select modelLineCode from inventory where dealerNum = '" + e.dealerNum + "' and vin = '" + e.vin + "')";
	 		connection.query(queryStr,function(err,rows){
			 if(err) {
			 	connection.end();
			 	cb('error querying: ' + err.stack, null);
			 } else {
				  connection.end();
				  cb(null, rows);
			 }
			 
			}); // end of connection.query
  		} // end of if(err) -else
	}); // end of connect function
} // end of .handle function
