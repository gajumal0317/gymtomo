class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.string :part
      t.references :user, foreign_key: true
      t.references :gym, foreign_key: true

      t.timestamps
    end
  end
end
