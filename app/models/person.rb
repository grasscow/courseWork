class Person < ActiveRecord::Base
  has_attached_file :avatar, styles: {medium: "250x250>", thumb: "100x100>"}


  validates :name, presence: true
  validates :sex, inclusion: {in: %w(м ж)}, presence: true
  validate :check_birthday
  validates_attachment :avatar, content_type: {content_type: /\Aimage\/.*\z/}

  has_and_belongs_to_many :films, -> { ordering }
  has_many :produced_films, -> { ordering }, class_name: 'Film', foreign_key: :film_id

  scope :ordering, -> { (order(:name)) }


  private
  def check_birthday
    errors.add(:birthday, :invalid) if year && year>Date.today.year
    true
  end
end
