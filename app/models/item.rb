class Item < ActiveRecord::Base
	validates :title, presence: true
	validates :notes, presence: true
end
