var Smap = (function() {
  // module is the value of this anonymous function; it contains the names from this module.
  var module = {};

  module.log = function(level, message)
  {
    cordova.exec(null, null, 'SMAP', 'log', [level, message]);
  }

  module.logDebug = function(message)
  {
    module.log("DEBUG", message);
  }
  
  module.logInfo = function(message)
  {
    module.log("INFO", message);
  }

  module.logWarn = function(message)
  {
    module.log("WARN", message);
  }

  module.logError = function(message)
  {
    module.log("ERROR", message);
  }

  module.sendRequest = function(url, onSuccessHandler, onErrorHandler, method, data)
  {
    method = typeof method !== 'undefined' ? method : 'GET';
    data = typeof data !== 'undefined' ? data : null;
    cordova.exec(onSuccessHandler, onErrorHandler, 'SMAP', 'sendRequest', [url, method, data]);
  }

  module.sendJSON = function(url, onSuccessHandler, onErrorHandler, method, jsonObject)
  {
    method = typeof method !== 'undefined' ? method : 'GET';
    jsonObject = typeof jsonObject !== 'undefined' ? jsonObject : null;
    cordova.exec(onSuccessHandler, onErrorHandler, 'SMAP', 'sendJSON', [url, method, jsonObject]);
  }
  
  module.signOut = function()
  {
    cordova.exec(null, null, 'SMAP', 'signout', []);
  }

  return module;
}());


