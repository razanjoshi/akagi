class RefactorCases < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :logo, :string, limit: 150
    add_column :cases, :started_at, :datetime
    add_column :cases, :ended_at, :datetime
    add_column :cases, :status, :integer, default: 0
    add_column :cases, :place, :string, limit: 50
  end
end
