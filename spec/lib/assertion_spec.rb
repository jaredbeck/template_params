require 'spec_helper'

module TemplateParams
  RSpec.describe Assertion do
    describe ".assert" do

      # # Assert `poll` is defined (no `NameError`)
      # template_param { poll }
      #
      # # Assert `@course` is defined.
      # # Meaningless because instance variables are always defined.
      # template_param { @course }
      #
      context "no arguments" do
        context "the given block raises a NameError" do
          it "raises an ArgumentError" do
            expect {
              described_class.assert { local_variable_that_does_not_exist }
            }.to(
              raise_error(ArgumentError) { |e|
                expect(e.message).to match(/\AUndefined template parameter: /)
                expect(e.message).to include("undefined local variable or method")
                expect(e.message).to include("local_variable_that_does_not_exist")
                expect(e.message).to include("described_class.assert { local_variable_that_does_not_exist }")
              }
            )
          end
        end

        context "the given block does not raise any errors" do
          it "does not raise an error" do
            extant = nil
            expect { described_class.assert { extant } }.to_not raise_error
          end

          it "never complains about instance variables (they are always defined)" do
            expect { described_class.assert { @foobar } }.to_not raise_error
          end
        end
      end

      # # Assert `poll.is_a?(::Poll)`
      # template_param(::Poll) { poll }
      #
      # # Assert `@course.is_a?(::Course)`
      # template_param(::Course) { @course }
      #
      context "one argument" do
        context "the given block matches the given type" do
          it "does not raise an error" do
            foo = :bar
            expect { described_class.assert(::Symbol) { foo } }.to_not raise_error
          end
        end

        context "the given block does not match the given type" do
          it "raises a TypeError" do
            foo = :bar
            expect { described_class.assert(::String) { foo } }.to raise_error(TypeError)
          end
        end

        context "the given type is nil" do
          it "does not raise an error" do
            foo = :bar
            expect { described_class.assert(nil) { foo } }.to_not raise_error
          end
        end
      end

      # # Assert `@course` is either a `::Course` or `nil`
      # template_param(::Course, allow_nil: true) { @course }
      context "two arguments" do
        context "allow_nil" do
          it "allows the given block to be nil" do
            expect {
              described_class.assert(::Symbol, allow_nil: true) { nil }
            }.to_not raise_error
          end
        end
      end
    end
  end
end
