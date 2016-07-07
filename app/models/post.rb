class Post < ActiveRecord::Base
  validates :title, presence: :true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]}
  validate :non_clickbait

  def non_clickbait
    return false if title.nil?
    baits = ["Won't Believe", "Secret", "Top ", "Guess"]
    unless baits.any? { |bait| self.title.include?(bait) }
      errors.add(:title, "can't be not clickbait-y")
    end
  end

end
# Finally, add a custom validator to Post that ensures the title is sufficiently
# clickbait-y. If the title does not contain "Won't Believe", "Secret", "Top
# [number]", or "Guess", the validator should return false.
