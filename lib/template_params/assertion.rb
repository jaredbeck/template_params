# frozen_string_literal: true

require "method_source"

module TemplateParams
  # A simple assertion suitable for view template preconditions.
  class Assertion
    # @api public
    def initialize(type, options)
      @type = type
      @options = options
    end

    # Convenience constructor.
    # @api public
    def self.assert(type = nil, options = {}, &block)
      new(type, options).apply(&block)
    end

    # Apply the instantiated assertion to the given block.
    # @api public
    def apply(&block)
      assert_type assert_defined(&block)
    end

    private

    # @api private
    def allow_nil
      @options.fetch(:allow_nil, false)
    end

    # Calls (yields to) the given block, and asserts that it does not
    # raise a NameError. Returns the return value of the block.
    # @api private
    def assert_defined(&block)
      value = nil
      begin
        value = yield
      rescue NameError => e
        raise ArgumentError, udef_msg(e, block)
      end
      value
    end

    # Raises a `TypeError` if `value` is not of `@type`.
    # @api private
    def assert_type(value)
      unless @type.nil? || value.is_a?(@type) || allow_nil && value.nil?
        raise TypeError, format("Expected %s, got %s", @type, value.class)
      end
    end

    # Given a `NameError` and the block, return a string like:
    #
    # Undefined template parameter:
    # undefined local variable or method `banana' for ..:
    # template_param(::Banana, allow_nil: true) { banana }
    #
    # `Proc#source` is provided by the `method_source` gem.
    #
    # @api private
    def udef_msg(name_error, block)
      prefix = "Undefined template parameter: #{name_error}"
      if block.respond_to?(:source)
        format("%s: %s", prefix, block.source.strip)
      else
        prefix
      end
    end
  end
end
