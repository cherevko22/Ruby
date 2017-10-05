module Acessors

  def self.included(base)
    base.extend ClassMethods
    #base.send :include, InstanceMethods
  end

    module ClassMethods
      def attr_accessor_with_history(*args)
        args.each do |arg|
            var_name = "@#{arg}".to_sym

            #Getter
            define_method(arg) { instance_variable_get(var_name) }

            #Setter
            define_method("#{arg}=".to_sym) do |value|
            instance_variable_set(var_name, value)

            #History
            @history ||= {}
            (@history[arg] ||= []) << value
            end

            define_method("#{arg}_history".to_sym) { @history[arg] }
          end
        end

        def strong_attr_accessor(name, name_class)
          var_name = "@#{name}".to_sym

          #Getter
          define_method(name) { instance_variable_get(var_name) }

          #Setter
          define_method("#{name}=".to_sym) do |value|
            raise 'Classes are different.' unless self.class == name_class
            instance_variable_set(var_name, value)
        end

      end
    end

end
