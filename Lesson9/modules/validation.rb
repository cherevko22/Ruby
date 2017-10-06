module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    attr_reader :rules

    def validate(name, validation_type, *options)
      @rules ||= []
      @rules << { validation_type: validation_type, name: name, options: options }
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
        rules = self.class.rules || self.class.superclass.rules
        rules.each do |rule|
          value = instance_variable_get("@#{rule[:name]}")
          send rule[:validation_type], rule[:name], value, rule[:options].first
        end
        true
      end
    end

    def presence(name, value, *_option)
      raise "#{self.class} #{name.capitalize} cannot be empty." if value.to_s.empty?
    end

    def format(name, value, regexp)
      raise "Unavailable format for #{name}." if value !~ regexp
    end

    def type(name, value, klass)
      raise "The class is not relevant." unless value.is_a?(klass)
    end

end
