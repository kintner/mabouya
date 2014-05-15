angular.module('mabouya.controllers', []).controller('TopUrlsController', function($scope, $http) {
  $http.get('/top_urls.json').success(function(data){
    $scope.topUrls = data
  });

});
