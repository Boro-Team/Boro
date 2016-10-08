class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
    	t.date :start_date, presence: true
    	t.date :end_date, presence: true
    	t.boolean :approval_status, default: false
    	t.float :total_price
    	t.integer :user_id
    	t.integer :item_id
      t.timestamps null: false
    end
  end

  def new

  	@item = Item.find(params[:item_id])
		@rental = Rental.new

  end
end
