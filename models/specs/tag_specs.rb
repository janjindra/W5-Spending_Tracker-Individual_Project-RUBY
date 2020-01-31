require('minitest/autorun')
require('minitest/reporters')
require_relative('../tag.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class TestTag < MiniTest::Test

  def setup
    @groceries = Tag.new({
      'label' => 'groceries',
      'active' => true,
      'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
      })
    end

    def test_has_label
      assert_equal('groceries',@groceries.label)
    end

    def test_is_actice
      assert_equal(true, @groceries.active)
    end

    def test_has_logo
      assert_equal('https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png', @groceries.logo)
    end

  end
