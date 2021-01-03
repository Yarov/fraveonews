class Promotion < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  before_create :set_promo_code
  
  def self.sizes
    {
      thumbnail: { resize: "300x300" },
    }
  end

  def sized(size)
    self.image.variant(Promotion.sizes[size]).processed
  end

  
  def self.search(search)
    if search
      self.find(self.search_basics(search))
    else
      self.all
    end
  
  end
  
  def self.search_basics(search)
    Promotion.where(
      "title ilike ? OR description ilike ?",
      "%#{search}%","%#{search}%"
    ).pluck(:id)
  end

  private

  def set_promo_code
    self.promocode = generate_promo_code
  end

  def generate_promo_code
    loop do
      promocode = "FRAVEO-#{SecureRandom.hex[0, 4].upcase}"
      break promocode unless Promotion.where(promocode: promocode).exists?
    end
  end



end
