class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :category, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :image, presence: {message: "を選択してください"}
  validates :body, presence: true, length: {maximum: 140}
  validates :place, length: {maximum: 140}
  validates :date, length: {maximum: 140}
  validates :memo, length: {maximum: 140}
  validates :category, presence: {message: "を選択してください"}

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  # scope :order_by_bookmark_count -> {joins(:bookmarks).order(bookmarks.count: :)  all.sort_by { |post| post.bookmarks.count }.reverse!}

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def get_fill_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def image_url
    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id) if user.present?
  end

end
