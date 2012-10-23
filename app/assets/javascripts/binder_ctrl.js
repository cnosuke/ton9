function BinderCtrl($http, $scope, $routeParams) {
  $scope.create = function() {
    $http.post('/binders/', { name: this.binder.name })
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

  $scope.set = function() {
    $scope.binder = { id: $routeParams.binder_id };
  }

  $scope.add = function(index) {
    $http.post('/binders/' + $scope.binder.id , { document_id: $scope.documents[index].id })
      .success(function(data) {
        if(data.result == 1) {
          //$scope.binders.push(data.data); 
          //location.href = "#/binders/" + data.data.id;
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
