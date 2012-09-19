class RemoveTimestampsFromPersonHobbies < ActiveRecord::Migration
  def self.up
    change_table :person_hobbies do |t|
      t.remove :created_at
      t.remove :updated_at
    end
  end

  def self.down
    change_table :person_hobbies do |t|
      t.timestamps
    end
  end
end
