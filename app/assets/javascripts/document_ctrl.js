function DocumentCtrl($http, $scope) {
  $scope.create = function() {
    $http.post('/users/document/create', {title: this.document.title})
      .success(function() {console.log(1);})
      .error(function() {console.log(0);});
  };

}
