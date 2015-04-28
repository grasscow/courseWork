class Film < ActiveRecord::Base
  belongs_to :country
  belongs_to :genre
  belongs_to :director, class_name: 'Person'

  has_and_belongs_to_many :people, -> { order(:name) }

  validates :name, presence: true
  validates :country, presence: true
  validates :director, presence: true
  validates :genre, presence: true
  validates :length, numericality: {only_integer: true, greater_than: 0}, allow_blank: true
  validates :year, numericality: {only_integer: true, greater_than: 1885}, allow_blank: true
  validate :check_people


  scope :ordering, -> { order(:year, :name) }

  private
  def check_people
    errors.add(:people, :blank) if people.blank?
    true
  end

end
