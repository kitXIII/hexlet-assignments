# frozen_string_literal: true

# BEGIN
require 'date'

FALSE_VALUES = [false, 0, '0', 'false', 'FALSE']

class String
  def to_boolean
    !FALSE_VALUES.include?(self)
  end

  def to_datetime
    DateTime.parse(self)
  end
end

class NilClass
  def to_boolean
    false
  end

  def to_datetime
    self
  end

  def to_s
    nil
  end
end

class TrueClass
  def to_boolean
    true
  end

  def to_i
    1
  end

  def to_datetime
    DateTime.new(1)
  end
end

class FalseClass
  def to_boolean
    false
  end

  def to_i
    0
  end

  def to_datetime
    DateTime.new(0)
  end
end

class Integer
  def to_boolean
    to_s.to_boolean
  end

  def to_datetime
    DateTime.new(self)
  end
end

class DateTime
  def to_i
    to_time.to_i
  end

  def to_boolean
    to_i.to_boolean
  end

  def to_datetime
    self
  end
end

module Model
  def self.included(base)
    base.class_variable_set('@@attributes_names', [])
    base.extend(ClassMethods)
  end

  def initialize(attributes = {})
    @attributes = {}

    attributes.each_pair do |key, value|
      send("#{key}=", value) if defined?("#{key}=")
    end
  end

  def attributes
    result = {}
    self.class.attributes_names.each do |key|
      result[key] = send(key) if defined?(key)
    end

    result
  end

  module ClassMethods
    def attribute(name, options = {})
      s_name = name.to_sym
      add_attributes_name(s_name)

      define_method(s_name) do
        return @attributes[s_name] if @attributes.key?(s_name)
        return options[:default] if options.key?(:default)
      end

      define_method("#{s_name}=") do |value|
        @attributes[s_name] = case options[:type]
                              when :integer
                                value.to_i
                              when :string
                                value.to_s
                              when :datetime
                                value.to_datetime
                              when :boolean
                                value.to_boolean
                              else
                                value
                              end
      end
    end

    def add_attributes_name(name)
      names = class_variable_get('@@attributes_names')
      class_variable_set('@@attributes_names', names << name)
    end

    def attributes_names
      class_variable_get('@@attributes_names')
    end
  end
end
# END
