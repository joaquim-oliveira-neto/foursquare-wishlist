class PagesController < ApplicationController

  def home
    fs = FoursquareService.new(user: current_user)
    @checkins = fs.get_recent_checkins_formatted
    @wishlist = fs.get_whishlist_formatted
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
