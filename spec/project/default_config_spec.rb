# frozen_string_literal: true

RSpec.describe 'config/default.yml' do
  subject(:default_config) do
    RuboCop::ConfigLoader.load_yaml_configuration('config/default.yml')
  end

  let(:namespaces) do
    {
      'rspec_rails' => 'RSpecRails'
    }
  end

  let(:cop_names) do
    glob = SpecHelper::ROOT.join('lib', 'rubocop', 'cop', 'rspec_rails', '*.rb')
    cop_names = Pathname.glob(glob).map do |file|
      file_name = file.basename('.rb').to_s
      cop_name  = file_name.gsub(/(^|_)(.)/) { Regexp.last_match(2).upcase }
      namespace = namespaces[file.dirname.basename.to_s]
      "#{namespace}/#{cop_name}"
    end

    cop_names - %w[RSpecRails/Base]
  end

  let(:config_keys) do
    cop_names + namespaces.values
  end

  def cop_configuration(config_key)
    cop_names.map do |cop_name|
      cop_config = default_config[cop_name]

      cop_config.fetch(config_key) do
        raise "Expected #{cop_name} to have #{config_key} configuration key"
      end
    end
  end

  it 'has configuration for all cops' do
    expect(default_config.keys)
      .to match_array(config_keys)
  end

  it 'sorts configuration keys alphabetically with nested namespaces last' do
    keys = default_config.keys.select { |key| key.start_with?('RSpecRails') }
    namespaced_keys = keys.select do |key|
      key.start_with?(*(namespaces.values - ['RSpecRails']))
    end

    expected = keys.sort_by do |key|
      namespaced = namespaced_keys.include?(key) ? 1 : 0
      "#{namespaced} #{key}"
    end

    keys.each_with_index do |key, idx|
      expect(key).to eq expected[idx]
    end
  end

  it 'has descriptions for all cops' do
    expect(cop_configuration('Description')).to all(be_a(String))
  end

  it 'does not have newlines in cop descriptions' do
    cop_configuration('Description').each do |value|
      expect(value).not_to include("\n")
    end
  end

  it 'ends every description with a period' do
    expect(cop_configuration('Description')).to all(end_with('.'))
  end

  it 'includes a valid Enabled for every cop' do
    expect(cop_configuration('Enabled'))
      .to all be(true).or(be(false)).or(eq('pending'))
  end
end
