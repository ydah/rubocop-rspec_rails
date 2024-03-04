# frozen_string_literal: true

require_relative 'rspec/rails/avoid_setup_hook'
require_relative 'rspec/rails/have_http_status'
require_relative 'rspec/rails/negation_be_valid'
begin
  require_relative 'rspec/rails/http_status'
rescue LoadError
  # Rails/HttpStatus cannot be loaded if rack/utils is unavailable.
end
require_relative 'rspec/rails/inferred_spec_type'
require_relative 'rspec/rails/minitest_assertions'
require_relative 'rspec/rails/travel_around'
