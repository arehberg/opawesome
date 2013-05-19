class CreateOpawesomeTestOptions < ActiveRecord::Migration
  def change
    create_table :opawesome_test_options do |t|
      t.integer :test_id
      t.integer :conversion_count, default: 0
      t.integer :selection_count, default: 0
      t.string :value

      t.timestamps
    end
  end
end
