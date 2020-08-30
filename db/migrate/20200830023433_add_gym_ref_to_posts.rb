class AddGymRefToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :gym, foreign_key: true, null: false
  end
end
