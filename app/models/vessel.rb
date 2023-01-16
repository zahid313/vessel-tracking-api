class Vessel < ApplicationRecord
    validates :name, :naccs_code, presence: true
    validates :naccs_code, uniqueness: true    
    has_many :voyages

    def current_voyage
        current_time = Time.now
        voyages.where('start_at <= ? and end_at >= ?', current_time, current_time).first
    end    
end
