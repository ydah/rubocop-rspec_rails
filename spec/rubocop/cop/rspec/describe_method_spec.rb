# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::DescribeMethod do
  it 'ignores describes with only a class' do
    expect_no_offenses('describe Some::Class do; end')
  end

  it 'enforces non-method names' do
    expect_offense(<<~RUBY)
      describe Some::Class, 'nope', '.incorrect_usage' do
                            ^^^^^^ The second argument to describe should be the method being tested. '#instance' or '.class'.
      end
    RUBY
  end

  it 'enforces non-method names with multi-line describe' do
    expect_offense(<<~'RUBY')
      describe Some::Class, "foo" \
                            ^^^^^^^ The second argument to describe should be the method being tested. '#instance' or '.class'.
        "bar" do
      end
    RUBY
  end

  it 'skips methods starting with a . or #' do
    expect_no_offenses(<<~RUBY)
      describe Some::Class, '.asdf' do
      end

      describe Some::Class, '#fdsa' do
      end
    RUBY
  end

  it 'skips methods starting with a . or # with multi-line describe' do
    expect_no_offenses(<<~'RUBY')
      describe Some::Class, ".foo" \
        "bar" do
      end

      describe Some::Class, "#foo" \
        "bar" do
      end
    RUBY
  end

  it 'skips specs not having a string second argument' do
    expect_no_offenses(<<~RUBY)
      describe Some::Class, :config do
      end
    RUBY
  end
end
