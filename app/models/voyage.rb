class Voyage < ApplicationRecord
  validates :from_place, :to_place, :start_at, :end_at, presence: true
  belongs_to :vessel #, touch: true
  validates_associated :vessel
  
  validate :start_at_cannot_be_same_as_end_at
  validate :from_place_cannot_be_same_as_to_place
  validate :validate_date_range_for_vessel

  private

  def validate_date_range_for_vessel
    overlapped_voyages = Voyage.where("vessel_id = ? AND ((start_at <= ?) and (end_at >= ?))", vessel_id, end_at, start_at)
    # first condition for create and second condition for update
    if (id.nil? && overlapped_voyages.present?) || (!id.nil? && overlapped_voyages.where.not(id: id).present?)  
        errors.add(:start_at, "and end at overlaps another voyayge of same vessel")
    end
  end  

  def start_at_cannot_be_same_as_end_at
    if start_at == end_at
      errors.add(:start_at, "can't be the same as end at")
    end
  end

  def from_place_cannot_be_same_as_to_place
    if from_place == to_place
      errors.add(:from_place, "can't be the same as to place")
    end
  end  
end
