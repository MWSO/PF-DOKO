class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :posts, through: :tag_relations
end
