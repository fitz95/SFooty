class AddAdditionalImagesAndVideoToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :additional_images, :string, array: true, default: []
    add_column :posts, :video, :string
  end
end
