require_relative 'controller/controller.rb'
require_relative 'modules/validation.rb'

require_relative 'modules/vendor.rb'
require_relative 'modules/instance_count.rb'

require_relative 'models/route.rb'
require_relative 'models/station.rb'
require_relative 'models/cargo_train.rb'
require_relative 'models/passenger_train.rb'
require_relative 'models/cargo_carriage.rb'
require_relative 'models/passenger_carriage.rb'

system 'clear'

def user_choice
  user_choice = gets.to_i
end

controller = Controller.new

loop do
  controller.menu
  controller.execute(user_choice)
end
