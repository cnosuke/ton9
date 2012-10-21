function DocumentCtrl($http, $scope) {
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

  $scope.get = function(document_id) {
    $http.get('documents/' + document_id)
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
