class AddClicksToStories < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :clicks, :integer, null: false, unsigned: true, default: 0
  end
end
