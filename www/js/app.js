// Flight Sequence App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'flight-sequence' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'flight-sequence.controllers' is found in controllers.js
angular.module('flight-sequence', ['ionic', 'flight-sequence.controllers'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
})

.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

    .state('app', {
      url: "/app",
      abstract: true,
      templateUrl: "templates/menu.html",
      controller: 'AppController'
    })

    .state('app.search', {
      url: "/search",
      views: {
        'menuContent' :{
          templateUrl: "templates/search.html"
        }
      }
    })

    .state('app.browse', {
      url: "/browse",
      views: {
        'menuContent' :{
          templateUrl: "templates/browse.html"
        }
      }
    })
    .state('app.flights', {
      url: "/flights",
      views: {
        'menuContent' :{
          templateUrl: "templates/flights.html",
          controller: 'FlightsController'
        }
      }
    })

    .state('app.single', {
      url: "/flights/:flightId",
      views: {
        'menuContent' :{
          templateUrl: "templates/flight.html",
          controller: 'FlightController'
        }
      }
    });
  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/app/flights');
});

