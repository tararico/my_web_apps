class RemoveAddPictureToBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :picture
  end
end
