require "template_params/view_helpers"

module TemplateParams
  class Railtie < Rails::Railtie
    initializer "template_params.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
