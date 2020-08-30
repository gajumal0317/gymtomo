class CreateGymUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :gym_users do |t|
      t.references :user, foreign_key: true
      t.references :gym, foreign_key: true

      t.timestamps
      t.index [:user_id, :gym_id], unique: true
    end
  end
end
