class Map < ActiveRecord::Base
  has_many :paths, dependent: :destroy

  validates :name, presence: true

  with_options allow_blank: true do |v|
    v.validates :name, uniqueness: true
  end
end
