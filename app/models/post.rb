class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :category
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :image, presence: true
  validates :body, presence: true
  # validates :category_id, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def bookmarked_by?(user)
    if user.present?
      bookmarks.exists?(user_id: user.id)
    end
  end

end
