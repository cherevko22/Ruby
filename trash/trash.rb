class Train
  include Validation

  attr_accessor :number, :route



  #Перед тем как создать объект, вызываем метод класса vlidate который в качестве первого
  # параметра примет номер поезда, таким образом:    :number > attr_reader :number > @number > Example: 12345
  # в качестве второго атрибута метод проверки номера, таким образом:
  # :presence > include Validation > instace method presence. По такой схеме:

  #def validate(name, validate_method, *options)
  #@rules << { validate_method: validate_method, name: name, options: options }

  #Вызываем метод validate три раза:
  validate :number, :presence
  #def validate(:number, :presence, [])
  #создан первый хэш и помещен в масив rules
  #@rules << { validate_method: :presence, name: :number, [] }
  validate :number, :format, /A-Z{0,3}/
  #def validate(:number, :format, [/A-Z{0,3}/])
  #создан второй хэш и помещен в масив rules
  #@rules << { validate_method: :format, name: :number, options: [/A-Z{0,3}/] }
  validate :route, :type, Route
  #def validate(:route, :type, [Route])
  #создан третий хэш и помещен в масив rules
  #@rules << { validate_method: :type, name: :route, options: [Route] }

  # Rules масив хешей:
  #rules [
  # =>    { validate_method: :presence, name: :number, [] },
  #       { validate_method: :format, name: :number, options: [/A-Z{0,3}/] },
  # =>    { validate_method: :type, name: :route, options: [Route] }
  #        ]

  def initialize(...)
    # ...
    validate!
  end
end


train = Train.new('ABC')
train2 = Train.new(345)

train.valid? # => true/false

######################################

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :rules

    def validate(name, validate_method, *options)
      @rules ||= []
      @rules << { validate_method: validate_method, name: name, options: options }
      # [
      #   { validate_method: :presence, name: :number, options: [] },
      #   { validate_method: :format, name: :number, options: [/A-Z{0,3}/] },
      #   { validate_method: :type, name: :route, options: [Route] }
      # ]
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue
      false
    end

    protected

    def validate!
      self.class.rules.each do |rule|
        value = instance_variable_get("@#{rule[:name]}") # instance_variable_get('@number')
        send rule[:validate_method], rule[:name], value, rule[:options].first
      # send :presence, :number, ???, nil
        # send :format, :number, ???, /A-Z{0,3}/
      end
      true
    end

    def presence(name, value, *_option)
      raise "#{self.class} #{name.capitalize} не может быть пустым." if value.to_s.empty?
    end

    def length_in_range(name, value, range)
      raise 'Не короче 3 и больше 15 символов.' unless range.cover?(value.length)
    end

    def format(name, value, regexp)
      raise "Недопустимый формат для #{name}." if value !~ regexp
    end

    def type(name, value, klass)
      raise "Тип объекта не соответствует заданному классу." unless value.is_a?(klass)
    end

    def uniqueness(name, value, *_option)
      ObjectSpace.each_object(self.class) { |obj| raise "#{value} существует" if obj.send(name) == value && obj != self }
    end

    def exists(name, value, *_option)
      raise "Станция не существует" unless Station.all.include?(value)
    end
  end
end
