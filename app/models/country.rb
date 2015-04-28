class Country < ActiveRecord::Base
  has_many :films, ->{ordering}, dependent: :destroy
end
