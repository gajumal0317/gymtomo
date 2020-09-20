class AddPartnerToTrainings < ActiveRecord::Migration[5.2]
  def change
    add_column :trainings, :partner, :string, default: 'なし'
  end
end
