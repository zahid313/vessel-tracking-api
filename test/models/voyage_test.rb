require "test_helper"

class VoyageTest < ActiveSupport::TestCase
  test "should not save voyage without from_place" do
    voyage = Voyage.new(to_place: "New York", start_at: Time.now, end_at: Time.now + 1.day, vessel: vessels(:one))
    assert_not voyage.save, "Saved the voyage without a from_place"
  end

  test "should not save voyage without to_place" do
    voyage = Voyage.new(from_place: "New York", start_at: Time.now, end_at: Time.now + 1.day, vessel: vessels(:one))
    assert_not voyage.save, "Saved the voyage without a to_place"
  end

  test "should not save voyage without start_at" do
    voyage = Voyage.new(from_place: "New York", to_place: "New York", end_at: Time.now + 1.day, vessel: vessels(:one))
    assert_not voyage.save, "Saved the voyage without a start_at"
  end

  test "should not save voyage without end_at" do
    voyage = Voyage.new(from_place: "New York", to_place: "New York", start_at: Time.now, vessel: vessels(:one))
    assert_not voyage.save, "Saved the voyage without a end_at"
  end

  test "should not save voyage without vessel" do
    voyage = Voyage.new(from_place: "New York", to_place: "New York", start_at: Time.now, end_at: Time.now + 1.day)
    assert_not voyage.save, "Saved the voyage without a vessel"
  end

  test "should not save voyage with same start_at and end_at" do
    voyage = Voyage.new(from_place: "New York", to_place: "New York", start_at: Time.now, end_at: Time.now, vessel: vessels(:one))
    assert_not voyage.save, "Saved the voyage with same start_at and end_at"
  end

  test "should not save voyage with same from_place and to_place" do
    voyage = Voyage.new(from_place: "New York", to_place: "New York", start_at: Time.now, end_at: Time.now + 1.day, vessel: vessels(:one))
    assert_not voyage.save, "Saved the voyage with same from_place and to_place"
  end


  test "should save voyage with valid attributes" do
    voyage = Voyage.new(from_place: "New York", to_place: "Los Angeles", start_at: Time.now, 
                       end_at: Time.now + 1.day, vessel: vessels(:one))
    assert voyage.save, "Saved voyage with valid attributes"
  end

  test "should update voyage with valid attributes" do
    voyage = voyages(:one)
    voyage.from_place = "Chicago"
    assert voyage.save!, "Updated voyage with valid attributes"
  end  
end
