class AddDetailsToCompetitions < ActiveRecord::Migration[7.0]
  def change
    add_reference :competitions, :user, foreign_key: true
    add_column :competitions, :start_date, :date
    add_column :competitions, :end_date, :date
    add_column :competitions, :status, :string
    add_column :competitions, :location, :string
    add_column :competitions, :description, :text

  end
end
