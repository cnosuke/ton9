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

  $scope.additem = function() {
    $http.post('documents/' + $routeParams.document_id + '/items', {content: this.item.body})
      .success(function(data) {
        if(data.result == 1) {
          $scope.document.items.unshift(data.data);
          $scope.item.body = "";
        }
        else {
          errorHandling(data.message);
        }
      })
      .error(function() {
        errorHandling(data.message);
      });
  };

  $scope.delete = function(i) {
      $http.delete('documents/'+$scope.documents[i].id, { })
          .success(function(data) {
              if(data.result == 1){
                  $scope.documents.splice(i,1);
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
