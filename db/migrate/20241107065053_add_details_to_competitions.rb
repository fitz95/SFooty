class AddDetailsToCompetitions < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:competitions, :user_id)
      add_column :competitions, :user_id, :integer
    end
    add_column :competitions, :start_date, :date
    add_column :competitions, :end_date, :date
    add_column :competitions, :status, :string
    add_column :competitions, :location, :string
    change_column :competitions, :description, :text

  end
end
