require "test_helper"

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory = create(:inventory)
    @survivor = @inventory.survivor
  end

  test "should get index" do
    get inventories_url, as: :json
    assert_response :success
  end

  test "should create inventory" do
    new_survivor = create(:survivor)
    assert_difference("Inventory.count") do
      post inventories_url, params: { inventory: { survivor_id: new_survivor.id } }, as: :json
    end

    assert_response :created
  end

  test "should show inventory" do
    get inventory_url(@inventory), as: :json
    assert_response :success
  end

  test "should update inventory" do
    new_survivor = create(:survivor)
    patch inventory_url(@inventory), params: { inventory: { survivor_id: new_survivor.id } }, as: :json
    assert_response :success
  end

  test "should destroy inventory" do
    assert_difference("Inventory.count", -1) do
      delete inventory_url(@inventory), as: :json
    end

    assert_response :no_content
  end
end
