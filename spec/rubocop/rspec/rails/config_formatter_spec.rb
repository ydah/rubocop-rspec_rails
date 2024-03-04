# frozen_string_literal: true

require 'rubocop/rspec/rails/config_formatter'

RSpec.describe RuboCop::RSpec::Rails::ConfigFormatter do
  let(:config) do
    {
      'AllCops' => {
        'Setting' => 'forty two'
      },
      'RSpec/Rails/Foo' => {
        'Config' => 2,
        'Enabled' => true
      },
      'RSpec/Rails/Bar' => {
        'Enabled' => true,
        'Nullable' => nil
      },
      'RSpec/Rails/Baz' => {
        'Enabled' => true,
        'StyleGuide' => '#buzz'
      }
    }
  end

  let(:descriptions) do
    {
      'RSpec/Rails/Foo' => {
        'Description' => 'Blah'
      },
      'RSpec/Rails/Bar' => {
        'Description' => 'Wow'
      },
      'RSpec/Rails/Baz' => {
        'Description' => 'Woof'
      }
    }
  end

  it 'builds a YAML dump with spacing between cops' do
    formatter = described_class.new(config, descriptions)

    expect(formatter.dump).to eql(<<~YAML)
      ---
      AllCops:
        Setting: forty two

      RSpec/Rails/Foo:
        Config: 2
        Enabled: true
        Description: Blah
        Reference: https://www.rubydoc.info/gems/rubocop-rspec-rails/RuboCop/Cop/RSpec/Rails/Foo

      RSpec/Rails/Bar:
        Enabled: true
        Nullable: ~
        Description: Wow
        Reference: https://www.rubydoc.info/gems/rubocop-rspec-rails/RuboCop/Cop/RSpec/Rails/Bar

      RSpec/Rails/Baz:
        Enabled: true
        StyleGuide: "#buzz"
        Description: Woof
        Reference: https://www.rubydoc.info/gems/rubocop-rspec-rails/RuboCop/Cop/RSpec/Rails/Baz
    YAML
  end
end
