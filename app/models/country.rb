class Country < ActiveRecord::Base
  has_many :films, -> { ordering }, dependent: :destroy

  scope :ordering, -> { order(:name) }


  def self.manage?(u)
    u.try(:admin?)
  end

  def can_destroy?
    films.blank?
  end
end
