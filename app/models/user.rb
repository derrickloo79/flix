class User < ApplicationRecord
  before_save :set_email_lowercase
  before_save :set_slug

  has_secure_password
  has_many :reviews, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :fav_movies, through: :favorites, source: :movie

  validates :name, presence: true, uniqueness: true
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def to_param
    slug
  end

  scope :by_name, -> { order(name: :asc) }
  scope :not_admins, -> { by_name.where(admin: false) }

private

  def set_email_lowercase
    self.email = email.downcase
  end

  def set_slug
    self.slug = name.parameterize
  end
end