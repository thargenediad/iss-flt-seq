angular.module('flight-sequence.controllers', [])

.controller('AppController', function($scope, $ionicModal, $timeout) {
  // Form data for the login modal
  $scope.loginData = {};

  // Create the login modal that we will use later
  $ionicModal.fromTemplateUrl('templates/logout.html', {
    scope: $scope
  }).then(function(modal) {
    $scope.modal = modal;
  });

  // Triggered in the login modal to close it
  $scope.closeLogout = function() {
    $scope.modal.hide();
  },

  // Open the login modal
  $scope.logout= function() {
    $scope.modal.show();
  };

  // Perform the login action when the user submits the login form
  $scope.doLogout = function() {
    console.log('Doing logout');

    $scope.closeLogout();
    Smap.signOut();
  };
})

.controller('IncrementsController', function($scope, $http) {
  $http.get('data/increments.xml').then(function(response) {

    // transform XML response into JSON
    var x2js = new X2JS();
    $scope.increments = x2js.xml_str2json(response.data).MIDAS.FlightIncrements.Increment;

    // create title and id attributes for each flight object
    angular.forEach($scope.increments, function(value, key) {
      value.title = value.IncName.replace(/"/g, "");  // remove double-quotes
      value.id = key;
    });
  });
})

.controller('IncrementController', function($scope, $stateParams) {
})
