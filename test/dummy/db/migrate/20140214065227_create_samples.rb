class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :name
      t.date :dated_at
      t.datetime :datetimed_at

      t.timestamps
    end
  end
end
