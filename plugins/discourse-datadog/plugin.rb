# frozen_string_literal: true

# name: DiscourseDatadog
# about: datadog instrumentation for discourse servers
# version: 0.1
# authors: galaktor
# url: https://github.com/galaktor/discourse-datadog

register_asset 'stylesheets/common/discourse-datadog.scss'
register_asset 'stylesheets/desktop/discourse-datadog.scss', :desktop
register_asset 'stylesheets/mobile/discourse-datadog.scss', :mobile

enabled_site_setting :discourse_datadog_enabled

PLUGIN_NAME ||= 'DiscourseDatadog'

load File.expand_path('lib/discourse-datadog/engine.rb', __dir__)

gem 'ddtrace', "0.37.0"

after_initialize do
  # https://github.com/discourse/discourse/blob/master/lib/plugin/instance.rb
  Datadog.configure do |c|
    c.use :active_record
    c.use :http
    c.use :redis
    c.use :sidekiq
  end
end
