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

        @scotrail = Merchant.new({
          'name' => 'Scotrail',
          'active' => true,
          'logo' => 'https://is5-ssl.mzstatic.com/image/thumb/Purple113/v4/45/05/b5/4505b56d-0131-c876-a76f-58610a3bc432/AppIcon-0-0-1x_U007emarketing-0-0-0-10-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/246x0w.png'
          })
          @scotrail.save()

          @easyjet = Merchant.new({
            'name' => 'EasyJet',
            'active' => true,
            'logo' => 'https://res-2.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1480921159/c5rjeyzcrqzcpxiea331.png'
            })
            @easyjet.save()

            @hsbc = Merchant.new({
              'name' => 'HSBC',
              'active' => true,
              'logo' => 'https://cdn.iconscout.com/icon/free/png-256/hsbc-282802.png'
              })
              @hsbc.save()

              @kfc = Merchant.new({
                'name' => 'KFC',
                'active' => true,
                'logo' => 'https://res-2.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1488265976/k2htrr9z4vsxkjbthskk.png'
                })
                @kfc.save()

                @nandos = Merchant.new({
                  'name' => 'Nandos',
                  'active' => true,
                  'logo' => 'https://res-1.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1495704518/jqmdlxyajlnmvirolutk.png'
                  })
                  @nandos.save()

                  @barbernetwork = Merchant.new({
                    'name' => 'Barber Network',
                    'active' => true,
                    'logo' => 'https://is5-ssl.mzstatic.com/image/thumb/Purple128/v4/68/31/89/683189e8-ba4f-f959-0d52-4bfcb17826d1/source/256x256bb.jpg'
                    })
                    @barbernetwork.save()

    @groceries = Tag.new({
      'label' => 'groceries',
      'active' => true,
      'logo' => '/images/t-groceries.png'
      })
      @groceries.save()

      @shopping = Tag.new({
        'label' => 'shopping',
        'active' => true,
        'logo' => '/images/t-shopping.png'
        })
        @shopping.save()

        @restaurants = Tag.new({
          'label' => 'restaurants',
          'active' => true,
          'logo' => '/images/t-restaurants.png'
          })
          @restaurants.save()

          @transport = Tag.new({
            'label' => 'transport',
            'active' => true,
            'logo' => '/images/t-transport.png'
            })
            @transport.save()

            @entertainment = Tag.new({
              'label' => 'entertainment',
              'active' => true,
              'logo' => '/images/t-entertainment.png'
              })
              @entertainment.save()

              @health = Tag.new({
                'label' => 'health',
                'active' => true,
                'logo' => '/images/t-health.png'
                })
                @health.save()

                @services = Tag.new({
                  'label' => 'services',
                  'active' => true,
                  'logo' => '/images/t-services.png'
                  })
                  @services.save()

                  @utilities = Tag.new({
                    'label' => 'utilities',
                    'active' => true,
                    'logo' => '/images/t-utilities.png'
                    })
                    @utilities.save()

                    @rent = Tag.new({
                      'label' => 'rent',
                      'active' => true,
                      'logo' => '/images/t-rent.png'
                      })
                      @rent.save()

                      @user1 = User.new({
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
                              @transaction3.time = Time.new(2019, 10, 22)
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

                                    @transaction7 = Transaction.new({
                                      'merchant_id' => @cineworld.id,
                                      'tag_id' => @entertainment.id,
                                      'user_id' => @user1.id,
                                      'amount' => 9,
                                      'time' => Time.now
                                      })
                                      @transaction7.save()
                                      @transaction7.time = Time.new(2019, 02, 22)
                                      @transaction7.update()

                                      @transaction8 = Transaction.new({
                                        'merchant_id' => @scotrail.id,
                                        'tag_id' => @transport.id,
                                        'user_id' => @user1.id,
                                        'amount' => 44,
                                        'time' => Time.now
                                        })
                                        @transaction8.save()
                                        @transaction8.time = Time.new(2019, 04, 12)
                                        @transaction8.update()

                                        @transaction9 = Transaction.new({
                                          'merchant_id' => @easyjet.id,
                                          'tag_id' => @transport.id,
                                          'user_id' => @user1.id,
                                          'amount' => 120,
                                          'time' => Time.now
                                          })
                                          @transaction9.save()
                                          @transaction9.time = Time.new(2019, 02, 30)
                                          @transaction9.update()

                                          @transaction10 = Transaction.new({
                                            'merchant_id' => @kfc.id,
                                            'tag_id' => @restaurants.id,
                                            'user_id' => @user1.id,
                                            'amount' => 17,
                                            'time' => Time.now
                                            })
                                            @transaction10.save()
                                            @transaction10.time = Time.new(2020, 02, 01)
                                            @transaction10.update()

                                            @transaction11 = Transaction.new({
                                              'merchant_id' => @hsbc.id,
                                              'tag_id' => @rent.id,
                                              'user_id' => @user1.id,
                                              'amount' => 540,
                                              'time' => Time.now
                                              })
                                              @transaction11.save()
                                              @transaction11.time = Time.new(2019, 02, 22)
                                              @transaction11.update()

                                              @transaction12 = Transaction.new({
                                                'merchant_id' => @nandos.id,
                                                'tag_id' => @restaurants.id,
                                                'user_id' => @user1.id,
                                                'amount' => 43,
                                                'time' => Time.now
                                                })
                                                @transaction12.save()
                                                @transaction12.time = Time.new(2020, 01, 20)
                                                @transaction12.update()

                                                @transaction13 = Transaction.new({
                                                  'merchant_id' => @barbernetwork.id,
                                                  'tag_id' => @services.id,
                                                  'user_id' => @user1.id,
                                                  'amount' => 11,
                                                  'time' => Time.now
                                                  })
                                                  @transaction13.save()
                                                  @transaction13.time = Time.new(2019, 10, 22)
                                                  @transaction13.update()

                                                  @transaction14 = Transaction.new({
                                                    'merchant_id' => @easyjet.id,
                                                    'tag_id' => @transport.id,
                                                    'user_id' => @user1.id,
                                                    'amount' => 88,
                                                    'time' => Time.now
                                                    })
                                                    @transaction14.save()


                                                    @transaction15 = Transaction.new({
                                                      'merchant_id' => @kfc.id,
                                                      'tag_id' => @restaurants.id,
                                                      'user_id' => @user1.id,
                                                      'amount' => 32,
                                                      'time' => Time.now
                                                      })
                                                      @transaction15.save()

                                                      @transaction16 = Transaction.new({
                                                        'merchant_id' => @barbernetwork.id,
                                                        'tag_id' => @services.id,
                                                        'user_id' => @user1.id,
                                                        'amount' => 8,
                                                        'time' => Time.now
                                                        })
                                                        @transaction16.save()
                                                        @transaction7.time = Time.new(2019, 01, 22)
                                                        @transaction7.update()
                                Tag.all()
                                Merchant.all()
                                Transaction.all()
                                User.all()

                                binding.pry
                                nil
