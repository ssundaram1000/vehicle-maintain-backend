var filter = require('lodash.filter');
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
	  		var queryStr = "call getVehiclesToService('" + e.dealerNum +"' ," + e.bufferDays + ")";
	 		connection.query(queryStr,function(err,rows){
			 if(err) {
			 	connection.end();
			 	cb('error querying: ' + err.stack, null);
			 } else {
				  connection.end();
				  var newList = getNewTaskList(rows[0])
				  //console.log(JSON.stringify(newList));
				  cb(null, newList);
			 }
			 
			}); // end of connection.query
  		} // end of if(err) -else
	}); // end of connect function
} // end of .handle function

function getNewTaskList(oldList) {
    var newList = [];
    oldList.forEach( function( item ) {
        var priorVehicles = filter(newList, { 'vin': item.vin } );
        if ( priorVehicles.length == 0  ) {
            // Create new vehicle
            var vehicle = {};
            vehicle.vin = item.vin;
            vehicle.modelYear = item.modelYear;
            vehicle.baseName = item.baseName;
            vehicle.modelLineCode = item.modelLineCode;
            vehicle.color = item.color;
            vehicle.swatchURL = item.swatchURL;
            vehicle.dealerNum = item.dealerNum;
            vehicle.dateReceived = item.dateReceived;
            vehicle.tasks = [];
            vehicle.tasks.push(createTaskItem(item));
            newList.push(vehicle);
        } else {
            //Since we found a vehicle, we only have to update Task List
            priorVehicles[0].tasks.push(createTaskItem(item));
        }
    });
    return newList;
}


function createTaskItem(item) {
    var taskItem = {};
    taskItem.checkListId = item.checkListId;
    taskItem.checkListDesc = item.checkListDesc;
    taskItem.frequency = item.frequency;
    taskItem.completedDate = item.completedDate;
    taskItem.latestCompletedDate = item.latestCompletedDate;
    taskItem.daysSince = item.daysSince;
    taskItem.daysBehind = item.daysBehind;
    return taskItem;
}

