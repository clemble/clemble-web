	$.ajaxSetup {
		statusCode: {
			401: -> window.location.replace('#registration')
			403: -> window.location.replace('#denied')
			404: -> window.location.replace('#error/404')
			500: -> window.location.replace('#error/500')
		}
		xhrFields: {
			withCredentials: true
		}
		dataType: "json"
	}