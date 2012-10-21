function MainCtrl($http, $scope) {
  $scope.documents = [];
  $scope.binders = [];

  $scope.sidebar = function() {
    $http.get('./all.json')
      .success(function(data) {
        if(data.result == 1) {
          $scope.$apply(function() {
            $scope.documents = data.data.docs;
            $scope.binders = data.data.bins;
          });
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
