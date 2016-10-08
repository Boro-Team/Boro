class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :title, presence: true, null: false
    	t.string :description, presence: true, null: false
    	t.integer :price_per_day, presence: true, null: false
    	t.json :avatars
    	t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
