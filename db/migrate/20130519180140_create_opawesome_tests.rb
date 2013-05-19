class CreateOpawesomeTests < ActiveRecord::Migration
  def change
    create_table :opawesome_tests do |t|
      t.string :key
      t.string :name

      t.timestamps
    end

    add_index :opawesome_tests, :key
  end
end

