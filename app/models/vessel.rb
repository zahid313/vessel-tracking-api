class Vessel < ApplicationRecord
    validates :name, :naccs_code, presence: true
    validates :naccs_code, uniqueness: true    
    has_many :voyages


    private 

    def current_voyage(vessel)
        vessel.voyages.where('start_at <= ? && end_at >= ?', Time.now).first
    end    
end
