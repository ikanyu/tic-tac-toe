get '/' do
  # Look in app/views/index.erb
  # byebug
  if !Game.last.nil?
    @game = Game.last
    @board = @game.board
  end
  if session[:name] == @game.turn
    @status = "play"
  else
    @status = "waiting"
  end
  # byebug
  erb :index
end

post '/' do
  # byebug
  game = Game.create
  player1 = game.users.create(name: "A")
  player2 = game.users.create(name: "B")
  game.turn = player1.name
  game.save
  # @board = game.board
  # erb :ind
  redirect to '/'
end

get '/selected' do
  position = params[:position]
  row = position[3]
  column = position[7]
  game = Game.find(params[:game_id])
  turn = game.turn
  # byebug
  game.board[row.to_i][column.to_i] = turn
  game.turn = game.users.where('name != ?', turn).first.name
  # byebug
  game.save

end

get '/status/:game_id' do
  # return the status of a job to an AJAX call
  game = Game.find(params[:game_id])
  current_turn = game.turn
  if current_turn == params[:from_player]
    status = 'play'
  else
    status = "waiting"
  end
  status
end

# .to_json

post '/login' do
  session[:name] = params["name"]
  redirect to '/'
end

post '/logout' do
  session[:name] = nil
  redirect to '/'
end