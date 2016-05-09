 (function($) {

	$.urlparams = function(UrlString) {
		var object = {};
		if (UrlString.indexOf('?') >= 0) {
			var param;
			var params = UrlString.slice(UrlString.indexOf('?') + 1).split('&');
			for (var i = 0; i < params.length; i++) {
				param = params[i].split('=');
				if (param[0].length > 0) {
					if (typeof param[1] === 'undefined') {
						object[param[0].toLowerCase()] = '';
					}
					else {
						object[param[0].toLowerCase()] = param[1];
					}
				}
			}
		}
		return object;		
	}

	$.posterPopup = function(URL,str_target,specs,replace) {
		
		if(URL.indexOf('?') >= 0) {
			var str_action = URL.slice(0,URL.indexOf('?'));
		}else{
			var str_action = URL;
		}
		
		var params = $.urlparams(URL);

		var form = $("<form/>", { action:str_action, method:'POST', target:str_target}	);
		for(item_name in params) {
			
			item_value =  params[item_name];
			
			form.append( 
				$("<input/>", 
					{ 
						type:'hidden', 
						name:item_name,
						value:item_value
					}
				 )
			);	

		}

		window.open("",str_target,specs,replace);

		form.appendTo("body").submit().remove();

	}

	$.posterPost = function(URL,str_target) {

		if(URL.indexOf('?') >= 0) {
			var str_action = URL.slice(0,URL.indexOf('?'));
		}else{
			var str_action = URL;
		}

		var params = $.urlparams(URL);

		var form = $("<form/>", { action:str_action, method:'POST', target:str_target}	);

		for(item_name in params) {
			
			item_value =  params[item_name];
			
			form.append( 
				$("<input/>", 
					{ 
						type:'hidden', 
						name:item_name,
						value:item_value
					}
				 )
			);	

		}

		form.appendTo("body").submit().remove();
		
	}

 })(jQuery);