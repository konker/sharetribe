class TutorialController < ApplicationController
  
  layout :choose_layout

  skip_filter :not_public_in_private_community, :dashboard_only
  skip_filter :single_community_only, :only => :create

  def requests
    @cur_path = tutorial_requests_path
    @next_path = tutorial_offers_path

    listings_per_page = 5
    @listings = Listing.requests.visible_to(@current_user, @current_community).open.limit(listings_per_page)
  end

  def offers
    @cur_path = tutorial_offers_path
    @next_path = tutorial_profile_path

    listings_per_page = 5
    @listings = Listing.offers.visible_to(@current_user, @current_community).open.limit(listings_per_page)
  end

  def profile
    @cur_path = tutorial_profile_path
    @next_path = tutorial_invite_path
  end

  def invite
    @cur_path = tutorial_invite_path
    @next_path = root_path
  end
  
  private
  
  def choose_layout
    if @current_community.private
      'private'
    else
      'application'
    end
  end
  
end
