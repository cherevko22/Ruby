require_relative 'route'
require_relative 'station'
require_relative 'train'

require_relative 'cargo_carriage'
require_relative 'cargo_train'

require_relative 'passanger_carriage'
require_relative 'passanger_train'

require_relative 'control'


system 'clear'

@controller = Controller.new

loop do
  @controller.menu
  user_choice = gets.to_i
  @controller.menu_choice(user_choice)
end
