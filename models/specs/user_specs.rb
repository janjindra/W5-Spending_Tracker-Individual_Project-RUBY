require('minitest/autorun')
require('minitest/reporters')
require_relative('../user.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class TestUser < MiniTest::Test

  def setup
    @jan = User.new({
      'name' => 'Jan',
      'budget_groceries' => 10,
      'budget_shopping' => 20,
      'budget_restaurants'  => 30,
      'budget_transport' => 40,
      'budget_entertainment' => 5,
      'budget_health' => 15,
      'budget_services' => 25,
      'budget_utilities' => 35,
      'budget_rent' => 45
      })
    end

    def test_has_name
      assert_equal('Jan',@jan.name)
    end

    def test_has_budget_groceries
      assert_equal(10, @jan.budget_groceries)
    end
    def test_has_budget_shopping
      assert_equal(20, @jan.budget_shopping)
    end
    def test_has_budget_restaurants
      assert_equal(30, @jan.budget_restaurants)
    end
    def test_has_budget_transport
      assert_equal(40, @jan.budget_transport)
    end
    def test_has_budget_entertainmen
      assert_equal(5, @jan.budget_entertainment)
    end
    def test_has_budget_health
      assert_equal(15, @jan.budget_health)
    end
    def test_has_budget_services
      assert_equal(25, @jan.budget_services)
    end
    def test_has_budget_utilities
      assert_equal(35, @jan.budget_utilities)
    end
    def test_has_budget_rent
      assert_equal(45, @jan.budget_rent)
    end


  end
