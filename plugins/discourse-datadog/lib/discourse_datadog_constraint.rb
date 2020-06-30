class DiscourseDatadogConstraint
  def matches?(request)
    SiteSetting.discourse_datadog_enabled
  end
end
