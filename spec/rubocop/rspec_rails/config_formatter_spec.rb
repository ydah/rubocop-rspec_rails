# frozen_string_literal: true

require 'rubocop/rspec_rails/config_formatter'

RSpec.describe RuboCop::RSpecRails::ConfigFormatter do
  let(:config) do
    {
      'AllCops' => {
        'Setting' => 'forty two'
      },
      'RSpecRails/Foo' => {
        'Config' => 2,
        'Enabled' => true
      },
      'RSpecRails/Bar' => {
        'Enabled' => true,
        'Nullable' => nil
      },
      'RSpecRails/Baz' => {
        'Enabled' => true,
        'StyleGuide' => '#buzz'
      }
    }
  end

  let(:descriptions) do
    {
      'RSpecRails/Foo' => {
        'Description' => 'Blah'
      },
      'RSpecRails/Bar' => {
        'Description' => 'Wow'
      },
      'RSpecRails/Baz' => {
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

      RSpecRails/Foo:
        Config: 2
        Enabled: true
        Description: Blah
        Reference: https://www.rubydoc.info/gems/rubocop-rspec_rails/RuboCop/Cop/RSpecRails/Foo

      RSpecRails/Bar:
        Enabled: true
        Nullable: ~
        Description: Wow
        Reference: https://www.rubydoc.info/gems/rubocop-rspec_rails/RuboCop/Cop/RSpecRails/Bar

      RSpecRails/Baz:
        Enabled: true
        StyleGuide: "#buzz"
        Description: Woof
        Reference: https://www.rubydoc.info/gems/rubocop-rspec_rails/RuboCop/Cop/RSpecRails/Baz
    YAML
  end
end
