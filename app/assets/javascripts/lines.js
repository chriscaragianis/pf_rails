var plot_data = function(forecast) {
  lines = [];
  for (var acct in forecast.accounts) {
     var dataObject = {};
     dataObject.label = acct;
     dataObject.data = forecast.accounts[acct].balances;
     lines.push(dataObject);
  }
  return lines;
}

var xaxis_data = function(forecast) {
  var dataObject = {
    mode: "time",
    ticklength: 0,
    timeformat: "%m/%d/%y"
  }  
  return dataObject;
}

var generateChart = function() {
  var data = $.ajax( {
    url: '/plotdata',
    data: {
      plan_choice: $("#plan_choice").val(),
      balance: $("#balance").val(),
      start_date: $("#start_date").val(),
      end_date: $("#end_date").val()
    },
    dataType: "json",
    success: function(resp) {
      console.log("SUCCESS")
      console.log(resp);
      $(".big-title").hide();
      $(".forecast-box").addClass("fadeOutLeft animated");
      $(".demo-container").addClass("animated");
      $(".demo-container").show();
      $.plot("#placeholder", plot_data(resp), {
        xaxis: xaxis_data(resp)
      });
      $("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
    },
    error: function(resp) {
      console.log("FAIL")
      console.log(resp);
    }
  });
};




    
