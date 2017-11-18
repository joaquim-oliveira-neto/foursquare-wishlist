class PagesController < ApplicationController

  def home
    client = Foursquare2::Client.new(
      :client_id => ENV['FOURSQUARE_ID'],
      :client_secret => ENV['FOURSQUARE_SECRET'],
      :api_version => '20171117',
      :oauth_token => current_user.access_token
      )

    @friends_venues = []
    client.recent_checkins.each do |checkin|
      venue = checkin.venue
      venue_id = venue.id
      @friends_venues << {
        friend_photo: "#{checkin.user.photo.prefix}100x100#{checkin.user.photo.suffix}",
        image: "#{client.venue_photos(venue_id).items[0].prefix}300x300#{client.venue_photos(venue_id).items[0].suffix}",
        name: venue.name
        }
    end

    user_venues = Venue.where(user: current_user)
    @wishlist = []
    user_venues.each do |user_venue|

      venue = client.venue(user_venue.venue_id)
      @user_venues << {
        image: "#{client.venue_photos(venue.id).items[0].prefix}300x300#{client.venue_photos(venue.id).items[0].suffix}",
        name: venue.name
        }
    end

  end

  def create

  end

  private

  def get_venue_image(venue_id)


  end

end
