// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on("ready", function(){
  $(".follow").click(function(e){
    e.preventDefault();
    if(e.currentTarget.innerText === "Follow"){
      $.ajax({
        url: "/electeds/"+e.currentTarget.value+"/electeds_users",
        type: "POST",
        data: {
          "elected_id": e.currentTarget.value
        }
      }).done(function(){console.log("DONE")});
      e.currentTarget.innerText = "Unfollow"
    }else{
      $.ajax({
        url: "/electeds/"+e.currentTarget.value+"/electeds_users/"+e.currentTarget.value,
        type: "DELETE",
        data: {
          "elected_id": e.currentTarget.value
        }
      }).done(function(){console.log("DONE")});
      e.currentTarget.innerText = "Follow";
    }
  });
});

