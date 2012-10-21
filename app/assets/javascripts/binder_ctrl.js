function BinderCtrl($http, $scope, $routeParams) {
  $scope.create = function() {
    $http.post('/binders/', { title: this.binder.name })
      .success(function(data) {
        if(data.result == 1) {
          $scope.binders.push(data.data); 
          location.href = "#/binders/" + data.data.id;
        }
        else {
          errorHandling(data.message);
        }
      })
      .error(function() {
        errorHandling(data.message);
      });
  };

  $scope.get = function() {
    $http.get('documents/' + $routeParams.document_id)
      .success(function(data) {
        if(data.result == 1) {
          $scope.document = data.data.document; 
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
