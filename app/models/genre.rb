class Genre < ActiveRecord::Base
  has_many :films, -> { ordering }, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :ordering, -> { order(:name) }

end
