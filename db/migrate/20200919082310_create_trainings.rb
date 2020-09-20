class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.integer :part1, default: 0
      t.integer :part2, default: 0
      t.integer :part3, default: 0
      t.references :user, foreign_key: true, null: false
      t.references :gym, foreign_key: true, null: false

      t.timestamps
    end
  end
end
