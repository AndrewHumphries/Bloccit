class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :images, :image
  end
end
