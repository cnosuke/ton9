function SidebarCtrl($http, $scope) {
  $scope.init = function() {
    $scope.documents = [
      {title: 'document1'},
      {title: 'document2'},
    ];
    $scope.binders = [
      {name: 'binder1'},
      {name: 'binder2'},
    ];
  };
}
