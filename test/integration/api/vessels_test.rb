require "test_helper"

class Api::VesselsTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_vessels_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal Vessel.all.order('id asc').to_json, json_response['vessels'].to_json
  end

  test "should create vessel" do
    post api_vessels_url, as: :json, params: { vessel: { name: 'vessel1', owner_id: 1, naccs_code: '123' } }
    assert_response :created
    assert_equal Vessel.last.to_json, @response.body
  end

  test "should update vessel" do
    vessel = Vessel.create(name: "vessel1", naccs_code: "123")
    patch api_vessel_url(vessel), params: { vessel: { name: "vessel2" } }, as: :json
    assert_response :success
  end

  test "should get current voyage" do
    @vessel = vessels(:one)
    @voyage = Voyage.create!(from_place: "Los Angeles", to_place: "Shanghai", start_time: Time.now - 1.day, end_time: Time.now + 1.day, vessel: @vessel)    
    get current_voyage_vessel_path(@vessel)
    assert_response :success
    assert_equal @voyage.to_json, @response.body
  end 

end
