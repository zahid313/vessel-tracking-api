require "test_helper"

class Api::VoyagesTest < ActionDispatch::IntegrationTest
  test "creating a new voyage" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    post api_voyages_path,  as: :json,
                            params: { voyage: { from_place: "Port 1", to_place: "Port 2", 
                                    start_at: Time.now + 1.day, end_at: Time.now, vessel_id: vessel.id } }
    assert_response :created
    assert_equal "Port 1", JSON.parse(response.body)["from_place"]
    assert_equal "Port 2", JSON.parse(response.body)["to_place"]
  end

  test "creating a voyage with equal start_at and end_at should fail" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    post api_voyages_path, as: :json, params: { voyage: { from_place: "Port 1", to_place: "Port 2", start_at: Time.now, end_at: Time.now, vessel_id: vessel.id } }
    assert_response :unprocessable_entity
    assert_equal "Validation failed: Start at can't be the same as end at", JSON.parse(response.body)["error"]
  end

  test "creating a voyage with over lapping start_at and end_at of a vessel should fail" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    start_at = Time.now
    end_at = Time.now + 1.day
    voyage = Voyage.create(from_place: "Port 1", to_place: "Port 2", start_at: start_at, end_at: end_at, vessel_id: vessel.id)
    post api_voyages_path, as: :json, params: { voyage: { from_place: "Port 1", to_place: "Port 2", start_at: start_at, end_at: end_at, vessel_id: vessel.id } }
    assert_response :unprocessable_entity
    assert_equal "Validation failed: Start at and end at overlaps another voyayge of same vessel", JSON.parse(response.body)["error"]
  end  
  
  test "creating a voyage with same from_place and to_place should fail" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    post api_voyages_path, as: :json, params: { voyage: { from_place: "Port 1", to_place: "Port 1", start_at: Time.now, end_at: Time.now + 1.hour, vessel_id: vessel.id } }
    assert_response :unprocessable_entity
    assert_equal "Validation failed: From place can't be the same as to place", JSON.parse(response.body)["error"]
  end

  test "updating a voyage" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    voyage = Voyage.create(from_place: "Port 1", to_place: "Port 2", start_at: Time.now, end_at: Time.now + 1.day, vessel_id: vessel.id)
    patch api_voyage_path(voyage), as: :json, params: { voyage: { from_place: "Port 3" } }
    assert_response :ok
    assert_equal "Port 3", JSON.parse(response.body)["from_place"]
  end

  test "updating a voyage with equal start_at and end_at should fail" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    voyage = Voyage.create(from_place: "Port 1", to_place: "Port 2", start_at: Time.now, end_at: Time.now + 1.hour, vessel_id: vessel.id)
    patch api_voyage_path(voyage), as: :json, params: { voyage: { start_at: Time.now, end_at: Time.now } }
    assert_response :unprocessable_entity
    assert_equal "Validation failed: Start at can't be the same as end at", JSON.parse(response.body)["error"]
  end
  
  test "updating a voyage with equal from_place and to_place should fail" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    voyage = Voyage.create(from_place: "Port 1", to_place: "Port 2", start_at: Time.now, end_at: Time.now + 1.hour, vessel_id: vessel.id)
    patch api_voyage_path(voyage), as: :json, params: { voyage: { from_place: "Port 1", to_place: "Port 1" } }
    assert_response :unprocessable_entity
    assert_equal "Validation failed: From place can't be the same as to place", JSON.parse(response.body)["error"]
  end
  
  test "showing a voyage" do
    vessel = Vessel.create(name: "Vessel 1", owner_id: 'JP005', naccs_code: 'DSQG9')
    voyage = Voyage.create(from_place: "Port 1", to_place: "Port 2", start_at: Time.now, end_at: Time.now + 1, vessel_id: vessel.id)
    get api_voyage_path(voyage), as: :json
    assert_response :ok
    assert_equal "Port 1", JSON.parse(response.body)["from_place"]
    assert_equal "Port 2", JSON.parse(response.body)["to_place"]
  end
    
end
