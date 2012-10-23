angular.module('ton9', [])
  .config(['$routeProvider', function($routeProvider) {
    $routeProvider.
        when('/', {templateUrl: '/assets/index.html'}).
        when('/documents/create', {templateUrl: '/assets/create_document.html'}).
        when('/documents/list', {templateUrl: '/assets/list_document.html'}).
        when('/documents/:document_id', {templateUrl: '/assets/document.html', controller: DocumentCtrl}).

        when('/binders/create', {templateUrl: '/assets/create_binder.html'}).
        when('/binders/:binder_id', {templateUrl: '/assets/binder.html', controller: ItemCtrl}).
        otherwise({redirectTo: '/'});
  }])
  .config(["$httpProvider", function(provider) {
    provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }]);
