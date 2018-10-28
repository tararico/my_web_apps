class Book < ApplicationRecord
  has_one_attached :book_image
  #mount_uploader :picture, PictureUploader
end
