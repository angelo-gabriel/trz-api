require "test_helper"

class SurvivorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survivor = create(:survivor)
  end

  test "should get index" do
    get survivors_url, as: :json
    assert_response :success
  end

  test "should create survivor" do
    assert_difference("Survivor.count", 1) do
      post survivors_url, params: { survivor: { age: @survivor.age, gender: @survivor.gender, latitude: @survivor.latitude, longitude: @survivor.longitude, name: @survivor.name, infected: @survivor.infected } }, as: :json
    end

    assert_response :created
  end

  test "should show survivor" do
    get survivor_url(@survivor), as: :json
    assert_response :success
  end

  test "should update survivor" do
    patch survivor_url(@survivor), params: { survivor: { age: @survivor.age, gender: @survivor.gender, latitude: @survivor.latitude, longitude: @survivor.longitude, name: @survivor.name, infected: @survivor.infected } }, as: :json
    assert_response :success
  end

  test "should destroy survivor" do
    assert_difference("Survivor.count", -1) do
      delete survivor_url(@survivor), as: :json
    end

    assert_response :no_content
  end
end
