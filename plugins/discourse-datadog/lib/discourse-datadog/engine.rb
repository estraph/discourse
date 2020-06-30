module DiscourseDatadog
  class Engine < ::Rails::Engine
    engine_name "DiscourseDatadog".freeze
    isolate_namespace DiscourseDatadog

    config.after_initialize do
      Discourse::Application.routes.append do
        mount ::DiscourseDatadog::Engine, at: "/discourse-datadog"
      end
    end
  end
end
