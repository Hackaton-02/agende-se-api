if Rails.env.development? || Rails.env.test?
    require 'factory_bot'
  
    namespace :dev do
      desc 'Sample data for local development environment'
      task prime: 'db:setup' do
        include FactoryBot::Syntax::Methods
  
        35.times do
          profile = [:admin, :paciente, :especialista].sample
          create(:user, profile: profile)
          user = User.last
          create(:address, user_id: user.id)
        end

        150.times do
          bathroom = [true, false].sample
          airConditioned = [true, false].sample
          furnished = [true, false].sample
          internet = [true, false].sample
          bathroom = [true, false].sample

          create(:room, bathroom: bathroom, airConditioned: airConditioned, furnished: furnished, internet: internet)

          end

        24.times do
          room = Room.all.sample
          user = User.all.sample
          create(:room_rent, room_id: room.id, user_id: user.id)
        end
      end
    end
  end