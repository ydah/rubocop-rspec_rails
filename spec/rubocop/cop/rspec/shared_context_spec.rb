# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::SharedContext do
  describe 'shared_context' do
    it 'does not register an offense for empty contexts' do
      expect_no_offenses(<<~RUBY)
        shared_context 'empty' do
        end
      RUBY
    end

    it 'registers an offense for shared_context with only examples' do
      expect_offense(<<~RUBY)
        shared_context 'foo' do
        ^^^^^^^^^^^^^^^^^^^^ Use `shared_examples` when you don't define context.
          it 'performs actions' do
          end
        end
      RUBY

      expect_correction(<<~RUBY)
        shared_examples 'foo' do
          it 'performs actions' do
          end
        end
      RUBY
    end

    it 'does not register an offense for `shared_context` with let' do
      expect_no_offenses(<<~RUBY)
        shared_context 'foo' do
          let(:foo) { :bar }

          it 'performs actions' do
          end
        end
      RUBY
    end

    it 'does not register an offense for `shared_context` with subject' do
      expect_no_offenses(<<~RUBY)
        shared_context 'foo' do
          subject(:foo) { :bar }

          it 'performs actions' do
          end
        end
      RUBY
    end

    it 'does not register an offense for `shared_context` with before' do
      expect_no_offenses(<<~RUBY)
        shared_context 'foo' do
          before do
            something
          end

          it 'performs actions' do
          end
        end
      RUBY
    end
  end

  describe 'shared_examples' do
    it 'does not register an offense for empty examples' do
      expect_no_offenses(<<~RUBY)
        shared_examples 'empty' do
        end
      RUBY
    end

    it 'registers an offense for shared_examples with only let' do
      expect_offense(<<~RUBY)
        shared_examples 'foo' do
        ^^^^^^^^^^^^^^^^^^^^^ Use `shared_context` when you don't define examples.
          let(:foo) { :bar }
        end
      RUBY

      expect_correction(<<~RUBY)
        shared_context 'foo' do
          let(:foo) { :bar }
        end
      RUBY
    end

    it 'registers an offense for shared_examples with only subject' do
      expect_offense(<<~RUBY)
        shared_examples 'foo' do
        ^^^^^^^^^^^^^^^^^^^^^ Use `shared_context` when you don't define examples.
          subject(:foo) { :bar }
        end
      RUBY

      expect_correction(<<~RUBY)
        shared_context 'foo' do
          subject(:foo) { :bar }
        end
      RUBY
    end

    it 'registers an offense for shared_examples with only hooks' do
      expect_offense(<<~RUBY)
        shared_examples 'foo' do
        ^^^^^^^^^^^^^^^^^^^^^ Use `shared_context` when you don't define examples.
          before do
            foo
          end
        end
      RUBY

      expect_correction(<<~RUBY)
        shared_context 'foo' do
          before do
            foo
          end
        end
      RUBY
    end

    it 'does not register an offense for `shared_examples` with it' do
      expect_no_offenses(<<~RUBY)
        shared_examples 'foo' do
          subject(:foo) { 'foo' }
          let(:bar) { :baz }
          before { initialize }

          it 'works' do
          end
        end
      RUBY
    end
  end
end
