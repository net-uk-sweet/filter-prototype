// global var for flashReady
var comAmazeFlashReady = false;

// resolves movie using supplied id
function thisMovie(movieName) {

    return $("#" + movieName)[0];
//	if (navigator.appName.indexOf("Microsoft") != -1) 
//	{
//		return window[movieName]
//	}
//	else 
//	{
//		return document[movieName]
//	}
}

// standard interface for JavaScript calls on Flash
function flashInterface(jObj) 
{    
	return thisMovie("flashContent").flashInterface(jObj);
}

function externalInterfaceTest()
{
//	var type = document.getElementById("type").value;
//	var params = document.getElementById("params").value.split(",");
//	
//	// remove leading and trailing whitespace from params
//	for (var i = 0; i < params.length; i ++) 
//	{
//		params[i] = stripWhitespace(params[i]);
//	}
//	
//	var jObj = {"type": type, "params": params};
//	flashInterface(jObj);
}

// Indicates to Flash that Javascript is ready to receive calls
function fiJavascriptReady()
{
	console.log("JavaScript is ready");
	//output("JavaScript ready");
	return true;
}

// Indicates to JavaScript that Flash is ready to receive calls
function fiFlashReady()
{
	console.log("Flash is ready");
	comAmazeFlashReady = true;
}

// standard interface for Flash calls on JavaScript
function fiPageComm(jObj)
{		
	//output("Call made by Flash, type: " + jObj.type);
	
	switch(jObj.type)
	{	
		case "queue_test":
		output("Testing queue: " + jObj.count);
		break;
		
		case "redirect":
		output("Redirect url: " + jObj.url + " : window : " + jObj.window);
		if (jObj.analytics) doAnalytics(jObj.analytics);
		break;

		case "analytics":
		doAnalytics(jObj);
		break;

		case "share":
		output("Share url: " + jObj.url + " : window : " + jObj.window + " : sectionURL : " + jObj.sectionURL);
		break;

        case "slideDisplayed":
            output("Slide displayed: " + jObj.index);
            $.flashCarousel("slideDisplayed", jObj.index);
         
        break; 
		
		default:
		//window.alert("Object type " + jObj.type + " not recognised");
	}
}

// for debug only, outputs supplied message through output field
function output(msg)
{
	//document.getElementById("output").value = (msg + "\n" + document.getElementById("output").value);
}

// strips leading and trailing whitespace
// http://bytes.com/forum/thread165013.html
function stripWhitespace(str)
{
	return str.replace(/^\s*|\s*$/g, "");
}