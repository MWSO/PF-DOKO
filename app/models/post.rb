class Post < ApplicationRecord

  #アソシエーション
  has_one_attached :post_image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations
  belongs_to :user

  #バリデーション
  validates :post_image, presence: true
  validates :title, presence: true, length: { in: 1..20 }
  validates :body, presence: true, length: { in: 1..150 }
  validates :location, presence: true, length: { in: 1..20 }

  #投稿画像表示用のメソッド
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      post_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
      post_image.variant(resize_to_limit: [width, height]).processed
  end

  #ブックマークの確認用
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

 #タグ作成時管理用のメソッド
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    #モデル内に作成済みのタグ
    old_tags = current_tags - sent_tags
    #今回新しく追加されたタグ
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
       self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

 #タグ更新時のメソッド
  def update_tags(input_tags)
    registred_tags = tags.pluck(:name)
    #追加するタグ
    new_tags = input_tags - registred_tags
    #削除するタグ
    destroy_tags = registred_tags - input_tags

    new_tags.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag)
      tags << new_tag
    end

    destroy_tags.each do |tag|
      tag_id = Tag.find_by(name: tag)
      destroy_relation = TagRelation.find_by(tag_id: tag_id, post_id: id)
      destroy_relation.destroy
    end
  end

end
