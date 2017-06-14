class Micropost < ApplicationRecord
  belongs_to :user

  scope :order_type, ->{order created_at: :desc}
  scope :feed, ->(id){where "user_id = ?", id}

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content.max_length}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.picture_size.capacity_value.megabytes
      errors.add :picture, I18n.t(".error")
    end
  end
end
