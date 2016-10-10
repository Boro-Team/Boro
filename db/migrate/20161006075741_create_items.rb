class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :title, null: false
    	t.string :description, null: false
    	t.integer :price_per_day, null: false
    	t.json :avatars
    	t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end

