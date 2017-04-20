class AddTables < ActiveRecord::Migration
	def change
		create_table :questionvotes do |t|
			t.integer :question_id
			t.integer :user_id
			t.timestamps
		end

		create_table :answervotes do |t|
			t.integer :answer_id
			t.integer :user_id
			t.timestamps
		end
	end
end
