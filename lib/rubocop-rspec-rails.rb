# frozen_string_literal: true

require 'pathname'
require 'yaml'

require 'rubocop'
require 'rubocop-rspec'

require_relative 'rubocop/rspec/rails'

require_relative 'rubocop/cop/rspec-rails_cops'

RuboCop::AST::Node.include(RuboCop::RSpec::Node)
