class AddEnddateToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :end_date, :datetime
  end
end
