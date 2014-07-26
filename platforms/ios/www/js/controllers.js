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

.controller('IncrementsController', function($scope, increments) {
  increments.getIncrements().then(function (data) {
    $scope.increments = data;
  });
})

.controller('IncrementController', function($scope, $stateParams, increments) {
  increments.getFlights($stateParams.incrementId).then(function (data) {
    // $scope.flights must be an array
    if(Object.prototype.toString.call(data) != '[object Array]'){
      data = [].concat(data);
    }
    $scope.flights = data;
  });
})
