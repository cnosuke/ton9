function DocumentCtrl($http, $scope, $routeParams) {
  $scope.create = function() {
    $http.post('documents/', { title: this.document.title })
      .success(function(data) {
        if(data.result == 1) {
          $scope.documents.push(data.data); 
          location.href = "#/documents/" + data.data.id;
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
