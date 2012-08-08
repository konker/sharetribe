class ActionSuggestion < ActiveRecord::Base
  attr_accessible :caption, :image, :hobby_id, :action_type
  belongs_to :hobby

  scope :offer, where(:action_type => 'offer')
  scope :request, where(:action_type => 'request')

  VALID_TYPES = ["offer", "request"]
end
