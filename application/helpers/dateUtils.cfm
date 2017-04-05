<cfscript>
	private string function getDateTimeMessage( required date dateCreated ) output=false {
		var currentDateTime      = now();
		var dateTimeMessage      = "";
		var rangeToCompare       = "s,n,h,d,w,m,yyyy";
		var rangeToCompareLabel  = "second,minute,hour,day,week,month,year";
		var differentRange       = "60,60,24,7,4,12,1";
		var differentDirection   = "lt,lt,lt,lt,lt,lt,gt";
		var i = 1;

		loop list=rangeToCompare index="indexRange"{
			var different        = dateDiff(  indexRange, arguments.dateCreated, currentDateTime );
			var differentCompare = listGetAt( differentRange      , i );
			var compareDirection = listGetAt( differentDirection  , i );
			var rangeLabel       = listGetAt( rangeToCompareLabel , i );

			if( compareDirection EQ 'lt' ){
				validCompare = different LT differentCompare;
			}else if( compareDirection EQ 'gt' ){
				validCompare = different GT differentCompare;
			}

			if( validCompare ){
				if( different GT 1){
					rangeLabel = rangeLabel & 's';
				}
				dateTimeMessage = different & ' ' & rangeLabel;
				break;
			}

			i++;
		}

		return dateTimeMessage;
	}

</cfscript>