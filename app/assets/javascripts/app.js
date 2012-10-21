angular.module('ton9', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: '/assets/index.html'}).
      when('/documents/create', {templateUrl: '/assets/create_document.html'}).
      when('/documents/list', {templateUrl: '/assets/list_document.html'}).
      //when('/phones/:phoneId', {templateUrl: 'partials/phone-detail.html', controller: PhoneDetailCtrl}).
      otherwise({redirectTo: '/'});
}]);
