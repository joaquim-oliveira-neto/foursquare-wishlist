class FoursquareService
  def initialize(params = {})
    @user = params[:user]
    @client = create_client
  end

  def get_recent_checkins_formatted
    checkins = []
    @client.recent_checkins.each do |checkin|
      venue = checkin.venue
      user  = checkin.user

      next if Place.find_by(checkin_id: checkin.id)
      next if user.id == @user.uid

      checkins << {
        checkin_id:  checkin.id,
        venue_photo: get_venue_photo_as_url(venue),
        venue_name:  venue.name,
        user_photo:  get_user_photo_as_url(user)
      }
    end
    checkins
  end

  def get_whishlist_formatted
    wishlist = []
    user_places = @user.places
    user_places.each do |place|
      checkin = @client.checkin(place.checkin_id)
      venue = checkin.venue
      wishlist << {
        place_id: place.id,
        venue_photo: get_venue_photo_as_url(venue),
        venue_name:  venue.name,
        }
    end
    wishlist
  end

  private

  def create_client
    Foursquare2::Client.new(
      :client_id => ENV['FOURSQUARE_ID'],
      :client_secret => ENV['FOURSQUARE_SECRET'],
      :api_version => '20171117',
      :oauth_token => @user.access_token
    )
  end

  def get_venue_photo_as_url(venue)
    venue_photos = @client.venue_photos(venue.id)
    return "" if venue_photos.items.empty?

    venue_photo_params = venue_photos.items[0]
    photo_prefix       = venue_photo_params.prefix
    photo_suffix       = venue_photo_params.suffix

    "#{photo_prefix}300x300#{photo_suffix}"
  end

  def get_user_photo_as_url(user)
    photo_prefix       = user.photo.prefix
    photo_suffix       = user.photo.suffix

    "#{photo_prefix}100x100#{photo_suffix}"
  end
end
