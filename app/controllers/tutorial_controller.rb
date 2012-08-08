class TutorialController < ApplicationController
  
  layout :choose_layout

  skip_filter :not_public_in_private_community, :dashboard_only
  skip_filter :single_community_only, :only => :create

  def requests
    @cur_path = tutorial_requests_path
    @next_path = tutorial_offers_path

    max_listings = 5
    @listings = Listing.requests.visible_to(@current_user, @current_community).open.limit(max_listings)

    num_suggestions = 6
    @suggestions = get_suggestions(num_suggestions, 'request')
  end

  def offers
    @cur_path = tutorial_offers_path
    @next_path = tutorial_profile_path

    max_listings = 5
    @listings = Listing.offers.visible_to(@current_user, @current_community).open.limit(max_listings)

    num_suggestions = 6
    @suggestions = get_suggestions(num_suggestions, 'offer')
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
  
  def get_suggestions(n, action_type)
    suggestions = []
    chosen = []

    # get the current user's "official" hobbies
    hobbies = @current_person.hobbies.official

    # fetch the action_suggestions using these hobbies
    hobbies.each do |h|
      if h.action_suggestions.where(:action_type => action_type).size > 0
        # get a random index into the suggestions
        i = rand(h.action_suggestions.where(:action_type => action_type).size)

        # choose this suggestion
        s = h.action_suggestions.where(:action_type => action_type)[i]
        suggestions << s

        # remember that it has been already chosen
        chosen << s.id

        if suggestions.size == n
          break
        end
      end
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
