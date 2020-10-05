IF(TEXT({!varSalutation}) = '', 
	IF(ISBLANK({!varFirstName}), 
		{!varLastName}, 
		{!varFirstName} + ' ' + {!varLastName}), 
	TEXT({!varSalutation}) + ' ' + '{!varFirstName}' + ' ' + {!varLastName})