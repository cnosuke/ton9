/*
$(".open").live('click',function() {
   form = $($(this).parent().find("form")[0]);
   form.toggle();
});
*/
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

  $scope.additem = function(id) {
    var elm = this
    $http.post('documents/' + $routeParams.document_id + '/items', {content: this.item.content, parent_item_id: id})
      .success(function(data) {
        if(data.result == 1) {
          elm.item.content = "";
          if(!id) {
            $scope.document.items.unshift({item: data.data});
          }
          else {
            elm.open = 0;
            addChild($scope.document.items, id, {item: data.data});
            console.log($scope.document.items);
          }
        }
        else {
          errorHandling(data.message);
        }
      })
      .error(function() {
        errorHandling(data.message);
      });
  };

  function addChild(items, id, data) {
    if(items == undefined) return;
    for(var i=0; i<items.length; i++) {
      item = items[i];
      if(item.item.id == id) {
        if(item.children == undefined) {
          item.children = [data];
        }
        else {
          item.children.push(data);
        }
        return;
      }
      else addChild(item.children, id, data);
    }
  }

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
