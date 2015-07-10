var game_id;
var session_name;
var game_status;

$(document).ready(function() {
  game_id = $('#game').data("game-id");
  session_name = $('span#name').text();
  game_status = $('#tbody').data('turn');

  $.ajax({
    type: "get",
    url: '/status/' + game_id,
    data: {from_player: session_name},
    complete: function(e) {
      if (e.responseText == 'play') {
      } else {
        setTimeout(function(){ check_my_status(game_id);}, 1000);
      }
    }
  });

  $('#tbody').on('click',function(e){
    if (game_status == 'waiting') {
        alert('Can you just be patient?!?!! crazy TicTacToe.');
        setTimeout(function(){ check_my_status(game_id); }, 1000);
        return;
    }

    var selected = e.toElement.id;
    $.ajax({
      type: "get",
      url: "/selected",
      data: { position: selected,
              game_id: game_id},
      complete: function(event){
        window.location.href = '/';
      }
    });

  }); //end of on click

}); //end of document ready

function check_my_status(game_id) {
  $.ajax({
    type: "get",
    url: '/status/' + game_id,
    data: {from_player: session_name},
    complete: function(e) {
      if (e.responseText == 'play') {
        window.location.href = '/';
      } else {
        setTimeout(function(){ check_my_status(game_id);}, 1000);
      }
    }
  });
}