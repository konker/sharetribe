class TutorialController < ApplicationController
  
  layout :choose_layout

  before_filter do |controller|
    controller.ensure_logged_in nil
  end

  skip_filter :not_public_in_private_community, :dashboard_only
  skip_filter :single_community_only

  def splash
    @name = @current_user.given_name_or_username
  end

  def requests
    @cur_path = tutorial_requests_path
    @next_path = tutorial_offers_path

    # store the next tutorial step in a session var
    session[:tutorial_next_path] = @next_path

    max_listings = 5
    @listings = Listing.requests.visible_to(@current_user, @current_community).open.limit(max_listings)

    num_suggestions = 6
    @suggestions = get_suggestions(num_suggestions, 'request')
  end

  def offers
    @cur_path = tutorial_offers_path
    @next_path = tutorial_profile_path

    # store the next tutorial step in a session var
    session[:tutorial_next_path] = @next_path

    max_listings = 5
    @listings = Listing.offers.visible_to(@current_user, @current_community).open.limit(max_listings)

    num_suggestions = 6
    @suggestions = get_suggestions(num_suggestions, 'offer')
  end

  def profile
    @cur_path = tutorial_profile_path
    @next_path = tutorial_invite_path

    # store the next tutorial step in a session var
    session[:tutorial_next_path] = @next_path
  end

  def invite
    @cur_path = tutorial_invite_path
    @next_path = root_path

    # remove the session var at the end of the tutorial
    session[:tutorial_next_path] = nil
  end
  
  private
  
  def choose_layout
    if @current_community.private
      'private'
    else
      'application'
    end
  end
  
  def get_suggestions(n, action_type)
    suggestions = []
    chosen = []

    # get the current user's "official" hobbies
    hobbies = @current_person.hobbies.official
    hobby_ids = hobbies.collect(&:id)

    # fetch the action suggestions which match these hobbies
    hobby_suggestions = ActionSuggestion.where(:action_type => action_type, :hobby_id => hobby_ids)

    # shuffle these suggestions and add them to the results
    if hobby_suggestions.size > 0
      suggestions.concat(hobby_suggestions.shuffle.slice(0, n))
      chosen.concat(hobby_suggestions.collect(&:id))
    end

    # if not enough, add some random ones
    if suggestions.size < n
      needed = n - chosen.size

      # get all suggestion ids
      # TODO: this won't changed much so should be cached once?
      suggestion_ids = ActionSuggestion.select(:id).where(:action_type => action_type).collect(&:id)

      # remove the ones already chosen
      suggestion_ids = suggestion_ids - chosen

      # shuffle them and choose the needed number of ids
      suggestion_ids = suggestion_ids.shuffle.slice(0, needed)

      if suggestion_ids.size > 0
        # fetch the suggestions and add them to the result
        suggestions.concat(ActionSuggestion.find(suggestion_ids))
      end
    end

    return suggestions
  end

end