class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  has_one_attached :avatar
  has_many_attached :images
  has_many_attached :files
  
  def avatar_path
    ActiveStorage::Blob.service.path_for(avatar.key)
  end

  def attachment_path(file)
    ActiveStorage::Blob.service.path_for(file.key)
  end
  
  resourcify
  has_many :users, through: :roles, class_name: 'User', source: :users
  has_many :creators, -> { where(:roles => {name: :creator}) }, through: :roles, class_name: 'User', source: :users
  has_many :editors, -> { where(:roles => {name: :editor}) }, through: :roles, class_name: 'User', source: :users

  scope :search_title, ->(title) { where("title LIKE ?", "%#{title}%") if title.present? }
  scope :search_content, ->(content) { where("content LIKE ?", "%#{content}%") if content.present? }

  # scope :search, lambda { |params|
  #   search_title(params[:title])
  #   .search_content(params[:content])
  # }
end
