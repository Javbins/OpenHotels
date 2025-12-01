class Hotel < ApplicationRecord
  before_create :generate_slug

  validates :name, presence: true, uniqueness: true

  private

  def generate_slug
    self.slug = name.parameterize
  end
end

