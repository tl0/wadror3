class Style < ActiveRecord::Base
  include RatingAverage
  has_many :ratings, through: :beers
  has_many :beers


  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -( b.average_rating || 0 ) }
    sorted_by_rating_in_desc_order.first(n)
  end

  def to_s
    name
  end
end
