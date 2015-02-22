class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1024,
                                   less_than_or_equal_to: ->(_){Time.now.year} }

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(n)
    sorted_by = Brewery.all.sort_by{:average_rating}
    sorted_by.first(n)
  end
end
