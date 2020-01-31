require('minitest/autorun')
require('minitest/reporters')
require_relative('../user.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class TestUser < MiniTest::Test

  def setup
    @jan = User.new({
      'name' => 'Jan',
      'budget' => 100
      })
    end

    def test_has_name
      assert_equal('Jan',@jan.name)
    end

    def test_has_budget
      assert_equal(100, @jan.budget)
    end


  end
