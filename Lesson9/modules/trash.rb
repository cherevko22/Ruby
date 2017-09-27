class Train
  include Validation

  attr_accessor :number, :route

  #Как работает метод validate:
  #def validate(name, validate_method, *options)
  #@rules << { validate_method: validate_method, name: name, options: options }

  #Вызываем метод validate три раза:

  #!!!Вопрос 1: когда мы после validate указываем :number, :presence это просто
  # значение для хэша что бы потом вызвать метод по символу? Это не имеет отношение к attr_accessor?

  validate :number, :presence
  #def validate(:number, :presence)
  #создан первый хэш и помещен в масив rules
  #@rules << { validate_method: :presence, name: :number, [] }
  validate :number, :format, /A-Z{0,3}/
  #def validate(:number, :format, /A-Z{0,3}/)
  #создан второй хэш и помещен в масив rules
  #@rules << { validate_method: :format, name: :number, options: [/A-Z{0,3}/] }
  validate :route, :type, Route
  #def validate(:route, :type, Route)
  #создан третий хэш и помещен в масив rules
  #@rules << { validate_method: :type, name: :route, options: [Route] }

  # Rules - масив хешей:
  #rules [
  #       { validate_method: :presence, name: :number, [] },
  #       { validate_method: :format, name: :number, options: [/A-Z{0,3}/] },
  #       { validate_method: :type, name: :route, options: [Route] }
  #        ]

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
      self.class.rules.each do |rule| #Перебирам масивa хешей с методами и атрибутами.
        value = instance_variable_get("@#{rule[:name]}") #Если в instance_variable_get стринг со знаком @ то метод считает его как переменную и вернет ее значение.
        #!!! Вопрос 2: Я правельно понимаю что в строке сверху, в скобках мы должны получить значене
        # переменной @number? И это значение было задонов в конструкторе?
        
        #         Метод               1й атриб.     2й        3й
        send rule[:validate_method], rule[:name], value, rule[:options].first
        #Метод      - инстанс метод валидации
        #1й атриб.  - ?
        #!!!Вопрос 3: 1й атрибут мы вернули по ключу :name и получили символ :number зачем?
        #2й атриб.  - Значение переменной "@#{rule[:name]}"
        #3й атриб.  - Заданная опция для проверки

        # send :presence, :number, ???, nil
        # send :format, :number, ???, /A-Z{0,3}/
      end
      true
    end


    def presence(name, value, *_option)
      raise "#{self.class} #{name.capitalize} не может быть пустым." if value.to_s.empty?
    end

    def format(name, value, regexp)
      raise "Недопустимый формат для #{name}." if value !~ regexp
    end

    def type(name, value, klass)
      raise "Тип объекта не соответствует заданному классу." unless value.is_a?(klass)
    end

  end
end
