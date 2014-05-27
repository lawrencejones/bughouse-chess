class AddGamesDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :totalGames, :integer, default: 0
    add_column :users, :wins, :integer, default: 0
    add_column :users, :lost, :integer, default: 0
    add_column :users, :draws, :integer, default: 0
    add_column :users, :points, :integer, default: 0
    add_column :users, :level, :string, default: "Beginner"
  end
end
