class Element < ActiveRecord::Base
  has_many :ropes
  has_many :inspections

  def slug
    return self.name.downcase.gsub(' ','-').gsub(/[^\w-]/,'')
  end

  def self.find_by_slug(text)
    self.all.detect {|instance| instance.slug == text}
  end
end
