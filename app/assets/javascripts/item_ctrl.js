function ItemCtrl($http, $scope, $routeProvider) {
  $scope.add = function() {
    $http.post('documents/' + $routeProvider.document_id + '/items', {content: this.item.body})
      .success(function(data) {
        if(data.result == 1) {
          $scope.document = data.data; 
        }
        else {
          errorHandling(data.message);
        }
      })
      .error(function() {
        errorHandling(data.message);
      });
  };
}
