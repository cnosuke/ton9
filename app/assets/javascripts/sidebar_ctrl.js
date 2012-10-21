function SidebarCtrl($http, $scope) {
  $scope.init = function() {
    $http.get('./all.json')
      .success(function(data) {
        if(data.result == 1) {
          $scpe.documents = data.docs;
          $scpe.binders = data.bins;
        }
        else {
          errorHandling();
        }
      })
      .error(errorHandling);
  };

  function errorHandling() {
    //alert("再度試してください");
  }
}
