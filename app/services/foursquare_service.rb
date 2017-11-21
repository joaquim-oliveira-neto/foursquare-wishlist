class FoursquareService
  def initialize(params = {})
    @user = params[:user]
    create_client
  end

  def get_recent_checkins_formatted
    @client.recent_checkins.each do |checkin|
      venue = checkin.venue
      user  = checkin.user

      checkins << {
        checkin_id:  checkin.id,
        venue_photo: "",#get_venue_photo_as_url(venue),
        venue_name:  venue.name,
        user_photo:  "",#get_user_photo_as_url(user)
      }
    end

    return checkins
  end

  def get_wishlist_formatted

  end

  private

  def create_client
    @client = Foursquare2::Client.new(
      :client_id => ENV['FOURSQUARE_ID'],
      :client_secret => ENV['FOURSQUARE_SECRET'],
      :api_version => '20171117',
      :oauth_token => @user.access_token
    )
  end
end
