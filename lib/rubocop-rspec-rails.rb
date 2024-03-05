# frozen_string_literal: true

require 'pathname'
require 'yaml'

require 'rubocop'
require 'rubocop-rspec'

require_relative 'rubocop/cop/rspec_rails_cops'

project_root = File.join(__dir__, '..')
RuboCop::ConfigLoader.inject_defaults!(project_root)

RuboCop::AST::Node.include(RuboCop::RSpec::Node)
