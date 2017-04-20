class AddUpDown < ActiveRecord::Migration
	def change
		add_column :questionvotes, :vote_type, :boolean
		add_column :answervotes, :vote_type, :boolean
	end
end
