require_relative( "../models/tag.rb" )
require_relative( "../models/transaction.rb" )
require_relative( "../models/merchant.rb" )
require_relative( "../models/user.rb" )
require("pry-byebug")




@tesco = Merchant.new({
  'name' => 'Tesco',
  'active' => true,
  'logo' => 'https://cdn.iconscout.com/icon/free/png-256/tesco-282827.png'
  })

  @tesco.save()

  @lidl = Merchant.new({
    'name' => 'Lidl',
    'active' => true,
    'logo' => 'https://cdn.iconscout.com/icon/free/png-256/lidl-282519.png'
    })

    @lidl.save()


  @groceries = Tag.new({
    'label' => 'groceries',
    'active' => true,
    'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
    })

    @groceries.save()

    @user1 = User.new({
      'name' => 'Jan',
      'budget' => 1000
      })

    @user1.save()

    @transaction1 = Transaction.new({
      'merchant_id' => @tesco.id,
      'tag_id' => @groceries.id,
      'user_id' => @user1.id,
      'amount' => 11.20,
      'time' => Time.now
      })

      @transaction1.save()

      @transaction2 = Transaction.new({
        'merchant_id' => @tesco.id,
        'tag_id' => @groceries.id,
        'user_id' => @user1.id,
        'amount' => 133.20,
        'time' => Time.now
        })

        @transaction2.save()


        @transaction3 = Transaction.new({
          'merchant_id' => @lidl.id,
          'tag_id' => @groceries.id,
          'user_id' => @user1.id,
          'amount' => 88,
          'time' => Time.now
          })

          @transaction3.save()

          @transaction2.time = Time.new(2018, 10, 31)
          @transaction2.update()

          @transaction3.time = Time.new(2019, 5, 22)
          @transaction3.update()

          @transaction4 = Transaction.new({
            'merchant_id' => @lidl.id,
            'tag_id' => @groceries.id,
            'user_id' => @user1.id,
            'amount' => 1111,
            'time' => Time.now
            })

            @transaction4.save()

            @transaction4.time = Time.new(2020, 02, 01)
            @transaction4.update()


          Tag.all()
          Merchant.all()
          Transaction.all()
          User.all()

        binding.pry
        nil
