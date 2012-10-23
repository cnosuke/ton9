$(".open").live('click',function() {
   form = $($(this).parent().find("form")[0]);
   form.toggle();
});

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
          console.log($scope.document.items);
        }
        else {
          errorHandling(data.message);
        }
      })
      .error(function() {
        errorHandling(data.message);
      });
  };

  $scope.additem = function(id) {
    $http.post('documents/' + $routeParams.document_id + '/items', {content: this.item.content, parent_item_id: id})
      .success(function(data) {
        if(data.result == 1) {
          if(!id) $scope.document.items.unshift({item: data.data});
          $scope.item.body = "";
          $scope.open = 0;
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
