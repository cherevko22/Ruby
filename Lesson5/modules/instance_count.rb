module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def instances=(number)
      @instances = number
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.instances += 1
    end
  end

end


# Методы класса:
# - instances, который возвращает кол-во экземпляров данного класса
# Инастанс-методы:
# - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора.
# При этом данный метод не должен быть публичным.
