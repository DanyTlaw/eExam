// Creates the module for this small angular app
var myApp = angular.module('test',[]);
// This Controller was with the old polling logic not needed but gonna keep it here if we want to reverse it to polling but i dont recommend it
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

// This controller is the one in use for the prototyp all functions are explained
myApp.controller("StatusController", ['$scope','$http', function($scope, $http){

  // This Url represents the root path of the Application
  var hosturl = "http://eexam.herokuapp.com";

  $scope.entries = {};
  // getting the variables from the html elements
  var courseID = $("#info").attr("course");
  var courseOfStudyID = $("#info").attr("courseOfStudy");
  console.log(courseID);
  console.log(courseOfStudyID);
  $scope.name = "";
  // The sourcelink is needed for the SSE connection and the getters
  var sourceLink = "/stream?" + "course_id=" +courseID + "&" + "course_of_study_id=" +courseOfStudyID;
  console.log(sourceLink);
  var link = "/stream";

  // This function starts the connection with the server and returns the Student entries
  $scope.sseFunction = function(){
    source = new EventSource(sourceLink);
    source.addEventListener("results", function(response){
      console.log(JSON.parse(response.data));

      $scope.$apply(function(){
        $scope.entries  = JSON.parse(response.data);
      });

    }, false);
  };

  // Function for initialize the site
  $scope.init = function(){
    // Acces attributes from the view to create the correct link
    var courseID = $("#info").attr("course");
    var courseOfStudyID = $("#info").attr("courseOfStudy");
    var sourceLink = "/getCourseStudents?" + "course_id=" +courseID + "&" + "course_of_study_id=" +courseOfStudyID;
      // get the data from the databse
      $http.get(sourceLink)
        .then(function(response){
          $scope.entries = response.data;
        }, function(error){
          alert(error);
        });
    };

  // Function for setting the online field in a student to false
  $scope.setOffline = function(id){
    // Sends a JSON file with the informations
      $http.post(hosturl + "/setOffline", [{"student_id": id}])
      .success(function(data){
        // debug message
        console.log("setOffline works");
      })
      .error(function(data){
        // debug message
        console.log("setOffline not working");
      });
  }

}]);
