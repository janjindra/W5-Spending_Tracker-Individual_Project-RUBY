require('minitest/autorun')
require('minitest/reporters')
require_relative('../transaction')
require_relative('../merchant')
require_relative('../tag')


Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new


class TestTransaction < MiniTest::Test


  def setup

    @tesco = Merchant.new({
      'name' => 'Tesco',
      'active' => true,
      'logo' => 'https://cdn.iconscout.com/icon/free/png-256/tesco-282827.png'
      })

      @groceries = Tag.new({
        'label' => 'groceries',
        'active' => true,
        'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
        })

        @transaction1 = Transaction.new({
          'merchant_id' => @tesco.id,
          'tag_id' => @groceries.id,
          'amount' => 11.20
          })
        end

        def test_has_amount
          assert_equal(11.20, @transaction1.amount)
        end

      end
