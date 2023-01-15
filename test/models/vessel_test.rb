require "test_helper"

class VesselTest < ActiveSupport::TestCase
  test "should create vessel" do
    vessel = Vessel.new(name: "vessel1", owner_id: 1, naccs_code: "123")
    assert vessel.save
  end

  test "should not create vessel with duplicate naccs_code" do
    Vessel.create(name: "vessel1",naccs_code: "123")
    vessel = Vessel.new(name: "vessel2",naccs_code: "123")
    assert_not vessel.save
  end
  
  test "should not create vessel with missing attributes" do
    vessel = Vessel.new
    assert_not vessel.save
  end

  test "should update vessel's attributes" do
    vessel = Vessel.create(name: "vessel1", owner_id: 1, naccs_code: "123")
    vessel.update(name: "vessel2")
    assert_equal "vessel2", vessel.reload.name
  end
  
  test "should not update vessel with duplicate naccs_code" do
    Vessel.create(name: "vessel1",naccs_code: "123")
    vessel = Vessel.create(name: "vessel2",naccs_code: "124")
    assert_not vessel.update(naccs_code: "123")
  end
  
  test "should delete vessel" do
    vessel = Vessel.create(name: "vessel1", owner_id: 1, naccs_code: "123")
    vessel.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Vessel.find(vessel.id) }
  end
    
  
end
