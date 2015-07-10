class Game < ActiveRecord::Base
  # Remember to create a migration!
  has_many :users
  # def complete?
  #   winning_state = [ ]
  # end
end
