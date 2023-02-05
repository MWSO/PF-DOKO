class Post < ApplicationRecord

  has_one_attached :post_image
  has_many :favorites
  has_many :comments
  has_many :tag_relations
  belongs_to :user


  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      post_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
      post_image.variant(resize_to_limit: [width, height]).processed
  end

end
