class Path < ActiveRecord::Base
  belongs_to :map

  validates :from, presence: true
  validates :to, presence: true
  validates :distance, numericality: true
  validates :map, presence: true

  with_options allow_blank: true do |v|
    v.validates :from, uniqueness: { scope: [:to, :map_id]}
    v.validates :to, uniqueness: { scope: [:from, :map_id]}
  end
end
