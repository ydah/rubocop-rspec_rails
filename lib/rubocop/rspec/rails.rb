# frozen_string_literal: true

module RuboCop
  module RSpec
    # RuboCop RSpec Rails project namespace
    module Rails
      PROJECT_ROOT   = Pathname.new(__dir__).parent.parent.parent.expand_path.freeze
      CONFIG_DEFAULT = PROJECT_ROOT.join('config', 'default.yml').freeze

      private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)
    end
  end
end
