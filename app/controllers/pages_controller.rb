class PagesController < ApplicationController

  def home
    foursquare_serivce = FoursquareService.new(user: current_user)
    @checkins = foursquare_serivce.get_recent_checkins_formatted
    @wishlist = foursquare_serivce.get_whishlist_formatted
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

end
