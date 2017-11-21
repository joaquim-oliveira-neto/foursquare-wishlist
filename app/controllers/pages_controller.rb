class PagesController < ApplicationController

  def home
    create_client

    @checkins = []
    @client.recent_checkins.each do |checkin|
      venue = checkin.venue
      user  = checkin.user

      next if Place.find_by(checkin_id: checkin.id)
      next if user.id == current_user.uid

      @checkins << {
        checkin_id:  checkin.id,
        venue_photo: get_venue_photo_as_url(venue),
        venue_name:  venue.name,
        user_photo:  get_user_photo_as_url(user)
      }
    end

    @wishlist = []
    user_places = current_user.places
    user_places.each do |place|
      checkin = @client.checkin(place.checkin_id)
      venue = checkin.venue
      @wishlist << {
        place_id: place.id,
        venue_photo: get_venue_photo_as_url(venue),
        venue_name:  venue.name,
        }
    end
  end

  def create
    place = Place.new(checkin_id: params[:checkin_id], user: current_user)
    if place.save!
      redirect_to root_path
    else
      raise "An error has occured"
    end

  end

  def destroy
    Place.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def create_client
    @client = Foursquare2::Client.new(
      :client_id => ENV['FOURSQUARE_ID'],
      :client_secret => ENV['FOURSQUARE_SECRET'],
      :api_version => '20171117',
      :oauth_token => current_user.access_token
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
