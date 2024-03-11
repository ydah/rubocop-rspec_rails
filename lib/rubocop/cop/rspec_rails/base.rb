# frozen_string_literal: true

module RuboCop
  module Cop
    module RSpecRails
      # @abstract parent class to RSpec Rails cops
      class Base < ::RuboCop::Cop::Base
        include RuboCop::RSpecRails::Language

        exclude_from_registry

        # Invoke the original inherited hook so our cops are recognized
        def self.inherited(subclass) # rubocop:disable Lint/MissingSuper
          RuboCop::Cop::Base.inherited(subclass)
        end

        # Set the config for dynamic DSL configuration-aware helpers
        # that have no other means of accessing the configuration.
        def on_new_investigation
          super
          RuboCop::RSpecRails::Language.config =
            config['RSpecRails']['Language']
        end
      end
    end
  end
end
