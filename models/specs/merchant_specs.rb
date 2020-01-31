require('minitest/autorun')
require('minitest/reporters')
require_relative('../merchant')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new


class TestMerchant < MiniTest::Test


  def setup
    @tesco = Merchant.new({
      'name' => 'Tesco',
      'active' => true,
      'logo' => 'https://cdn.iconscout.com/icon/free/png-256/tesco-282827.png'
      })
    end

    def test_has_name
      assert_equal("Tesco", @tesco.name)
    end

    def test_is_active
      assert_equal(true, @tesco.active)
    end

    def test_has_logo
        assert_equal('https://cdn.iconscout.com/icon/free/png-256/tesco-282827.png',@tesco.logo)
    end


  end
