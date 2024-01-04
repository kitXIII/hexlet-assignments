# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attributes_options
      @attributes_options || {}
    end

    def attribute(name, options = {})
      @attributes_options ||= {}
      @attributes_options[name] = options

      define_method name do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        prepared_value = options[:type] ? self.class.convert(value, options[:type]) : value
        instance_variable_set "@#{name}", prepared_value
      end
    end

    def convert(value, target_type)
      return value if value.nil?

      case target_type
      when :datetime
        DateTime.parse value
      when :integer
        Integer value
      when :string
        String value
      when :boolean
        !!value
      end
    end
  end

  def initialize(attrs = {})
    self.class.attributes_options.each do |name, options|
      value = attrs.key?(name) ? attrs[name] : options[:default]
      send("#{name}=", value)
    end
  end

  def attributes
    self.class.attributes_options.keys.each_with_object({}) do |name, acc|
      acc[name] = send(name)
    end
  end
end
# END
