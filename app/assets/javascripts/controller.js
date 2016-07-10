

var myApp = angular.module('test',[]);

myApp.controller('PollController', ['$scope','$http', '$timeout', function($scope, $http, $timeout){
    $scope.name = "daniel";
    $scope.entries = [];

    var poller =function(){
      $http.get("http://localhost:3000/api/apiget")
        .then(function(response){
          $scope.entries = response.data;
          // poller set on 2 sek after someone went online
          $timeout(poller,2000);
        }, function(error){
          alert("random");
        });
    }

    poller();
}]);

myApp.controller("StatusController", ['$scope', function($scope){

  $scope.entries = {};

  var courseID = $("#info").attr("course");
  var courseOfStudyID = $("#info").attr("courseOfStudy");
  console.log(courseID);
  console.log(courseOfStudyID);
  $scope.name = "";
  var sourceLink = "/stream?" + "course_id=" +courseID + "&" + "course_of_study_id=" +courseOfStudyID;
  console.log(sourceLink);
  var link = "/stream";

  $scope.init = function(){
    source = new EventSource(sourceLink);
    source.addEventListener("results", function(response){
      console.log(JSON.parse(response.data));

      $scope.$apply(function(){
        $scope.entries  = JSON.parse(response.data);
      });

    }, false);
  };

}]);

myApp.controller("ActionController", ['$scope'], function($scope){

})
