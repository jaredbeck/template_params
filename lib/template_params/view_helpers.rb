module TemplateParams
  module ViewHelpers
    def template_param(*args, &block)
      ::TemplateParams::Assertion.assert(*args, &block)
    end
  end
end
