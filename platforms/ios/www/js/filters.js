angular.module('flight-sequence.filters', [])

.filter('noDoubleQuotes', function() {
  return function(text) {
    return text.replace(/"/g, "");
  }
});