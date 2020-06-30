require_dependency "discourse_datadog_constraint"

DiscourseDatadog::Engine.routes.draw do
  get "/" => "discourse_datadog#index", constraints: DiscourseDatadogConstraint.new
  get "/actions" => "actions#index", constraints: DiscourseDatadogConstraint.new
  get "/actions/:id" => "actions#show", constraints: DiscourseDatadogConstraint.new
end
