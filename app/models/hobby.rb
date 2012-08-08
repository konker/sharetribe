class Hobby < ActiveRecord::Base
  attr_accessible :name, :official

  has_and_belongs_to_many :people, :join_table => 'person_hobbies'
  has_many :action_suggestions

  scope :official, where(:official => true)
  scope :unofficial, where(:official => false)
end
