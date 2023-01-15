class Vessel < ApplicationRecord
    validates :name, :naccs_code, presence: true
    validates :naccs_code, uniqueness: true    
    has_many :voyages
end
