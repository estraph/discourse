module DiscourseDatadog
  class DiscourseDatadogController < ::ApplicationController
    requires_plugin DiscourseDatadog

    before_action :ensure_logged_in

    def index
    end
  end
end
