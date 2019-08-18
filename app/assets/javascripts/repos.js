$(document).on("turbolinks:load", function() {
  $("#repos_search").on("keyup", function(e) {
    console.log("pressed")
    Rails.ajax({
      type: "POST",
      url: "repos/search",
      data: $("#repo_serach_form").serialize()
     });   
  });
});
