require 'faker'


task({ :sample_data => :environment }) do


erase_and_start_over = "N"

if erase_and_start_over == "Y"

  FollowRequest.destroy_all
  Comment.destroy_all
  Like.destroy_all
  Photo.destroy_all
  User.destroy_all
  
end

desc "Fill the database tables with some sample data"



usernames = Array.new { Faker::Name.first_name }

usernames << "alice"
usernames << "bob"

usernames.each do |username|
  User.create(
    email: "#{username}@example.com",
    password: "password",
    username: username.downcase,
    private: [true, false].sample,
  )
end


  p "Creating sample data"

  20.times do
    name = Faker::Name.first_name
    u = User.create(
      email: "#{name}@example.com",
      password: "password",
      username: name,
      private: [true, false].sample,
    )
    
    p u.errors.full_messages
    
  end

  p "There are now #{User.count} users."

  users = User.all

  users.each do |first_user|
    users.each do |second_user|

      if rand < 0.7
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: ["pending", "accepted", "rejected"].sample
        )      
      end
#----------------
      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end

    end

  end

  p "There are now #{FollowRequest.count} follow requests."

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::ChuckNorris.fact,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        if rand < 0.5 && !photo.fans.include?(follower)
          photo.fans << follower

          
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::ChuckNorris.fact,
            author: follower
          )
        end
      end
    end
  end
  p "There are now #{User.count} users."
  p "There are now #{FollowRequest.count} follow requests."
  p "There are now #{Photo.count} photos."
  p "There are now #{Like.count} likes."
  p "There are now #{Comment.count} comments."




end # Of task loop : sample_data: :environment do
