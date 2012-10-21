function MainCtrl($http, $scope) {
  $scope.documents = [];
  $scope.binders = [];

  $scope.sidebar = function() {
    $http.get('./all')
      .success(function(data) {
        if(data.result == 1) {
          $scope.documents = data.data.documents;
          $scope.binders = data.data.binders;
        }
        else {
          errorHandling(data.message);
        }
      })
      .error(errorHandling);
  };

  function errorHandling(mes) {
    alert(mes);
  }
}
