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

    @cineworld = Merchant.new({
      'name' => 'CineWorld',
      'active' => true,
      'logo' => 'https://apprecs.org/ios/images/app-icons/256/3f/508350271.jpg'
      })
      @cineworld.save()

      @boots = Merchant.new({
        'name' => 'Boots',
        'active' => true,
        'logo' => 'https://is2-ssl.mzstatic.com/image/thumb/Purple123/v4/68/6f/d4/686fd4b7-bd79-714e-5607-c16706ebc221/source/256x256bb.jpg'
        })
        @boots.save()


    @groceries = Tag.new({
      'label' => 'groceries',
      'active' => true,
      'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
      })
      @groceries.save()

      @shopping = Tag.new({
        'label' => 'shopping',
        'active' => true,
        'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
        })
        @shopping.save()

        @restaurants = Tag.new({
          'label' => 'restaurants',
          'active' => true,
          'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
          })
          @restaurants.save()

          @transport = Tag.new({
            'label' => 'transport',
            'active' => true,
            'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
            })
            @transport.save()

            @entertainment = Tag.new({
              'label' => 'entertainment',
              'active' => true,
              'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
              })
              @entertainment.save()

              @health = Tag.new({
                'label' => 'health',
                'active' => true,
                'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
                })
                @health.save()

                @services = Tag.new({
                  'label' => 'services',
                  'active' => true,
                  'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
                  })
                  @services.save()

                  @utilities = Tag.new({
                    'label' => 'utilities',
                    'active' => true,
                    'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
                    })
                    @utilities.save()

                    @rent = Tag.new({
                      'label' => 'rent',
                      'active' => true,
                      'logo' => 'https://www.shareicon.net/data/256x256/2016/08/19/817434_food_512x512.png'
                      })
                      @rent.save()

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
                            @transaction2.time = Time.new(2018, 10, 31)
                            @transaction2.update()

                            @transaction3 = Transaction.new({
                              'merchant_id' => @lidl.id,
                              'tag_id' => @groceries.id,
                              'user_id' => @user1.id,
                              'amount' => 88,
                              'time' => Time.now
                              })
                              @transaction3.save()
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

                                @transaction5 = Transaction.new({
                                  'merchant_id' => @boots.id,
                                  'tag_id' => @health.id,
                                  'user_id' => @user1.id,
                                  'amount' => 33,
                                  'time' => Time.now
                                  })
                                  @transaction5.save()
                                  @transaction5.time = Time.new(2020, 01, 05)
                                  @transaction5.update()

                                  @transaction6 = Transaction.new({
                                    'merchant_id' => @cineworld.id,
                                    'tag_id' => @entertainment.id,
                                    'user_id' => @user1.id,
                                    'amount' => 66,
                                    'time' => Time.now
                                    })
                                    @transaction6.save()
                                    @transaction6.time = Time.new(2019, 04, 22)
                                    @transaction6.update()

                                Tag.all()
                                Merchant.all()
                                Transaction.all()
                                User.all()

                                binding.pry
                                nil
