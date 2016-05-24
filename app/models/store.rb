class Store < ActiveRecord::Base
	validates :name, presence: true
	validates :category, presence: true
	validates :description, presence: true
  belongs_to :user
  before_save :set_visits_count

  def update_visits_count
  	self.save if self.visits_count.nil?
  	self.update(visits_count: self.visits_count + 1)
  end
  private

  def set_visits_count
  	self.visits_count ||= 0	
  end
end
