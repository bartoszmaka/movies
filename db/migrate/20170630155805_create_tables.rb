class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :actors do |t|
      t.string :first_name
      t.string :last_name

      t.integer :movies_count, default: 0

      t.index([:last_name, :first_name], unique: true)
    end

    create_table :movies do |t|
      t.string :name
      t.decimal :revenue, precision: 8, scale: 2

      t.belongs_to :genre, index: true
    end

    create_table :genres do |t|
      t.string :name

      t.integer :movies_count, default: 0
    end

    create_table :actor_movies do |t|
      t.belongs_to :actor, index: true
      t.belongs_to :movie, index: true
    end
  end
end
