function ItemCtrl($http, $scope) {
  $scope.init = function(document_id) {
    $http.get('documents/' + document_id + '/items')
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
