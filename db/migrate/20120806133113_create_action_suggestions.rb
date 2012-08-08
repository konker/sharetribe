class CreateActionSuggestions < ActiveRecord::Migration
  def self.up
    create_table :action_suggestions do |t|
      t.string :caption
      t.string :image
      t.string :action_type, :null => false
      t.references :hobby, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :action_suggestions
  end
end
