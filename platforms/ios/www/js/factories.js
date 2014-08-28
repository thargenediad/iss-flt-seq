angular.module('flight-sequence.factories', [])

.factory('increments', ['$http', function($http) {
    var incrementsFactory = {};

    incrementsFactory.data = '';
    console.log("In incrementsFactory.load");
    incrementsFactory.load = function() {
      console.log("In incrementsFactory.load");
      this.data = $http.get('data/increments.xml').then(function (response) {

        // transform XML response into JSON
        var x2js = new X2JS();
        var temp = x2js.xml_str2json(response.data).MIDAS.FlightIncrements.Increment;

        // create id attribute for each increment object
        angular.forEach(temp, function (value, key) {
          value.id = key;
        });
        return temp;
      });
      return this.data;
    }

    incrementsFactory.getIncrements = function() {
      return this.data === '' ? this.load() : this.data;
    };

    incrementsFactory.getFlights = function(incrementId) {
      return this.data === '' ? this.load() : this.data.then(function(data){
        return data[incrementId].Flight;
      });
    };

    return incrementsFactory;
}])