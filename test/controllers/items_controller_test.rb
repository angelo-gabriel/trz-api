require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create(:item)
  end

  test "should get index" do
    get items_url, as: :json
    assert_response :success
  end

  test "should create item" do
    inventory = create(:inventory)
    item_params = attributes_for(:item).merge(inventory_id: inventory.id)

    assert_difference("Item.count") do
      post items_url, params: { item: item_params }, as: :json
    end

    assert_response :created
  end

  test "should show item" do
    get item_url(@item), as: :json
    assert_response :success
  end

  test "should update item" do
    inventory = create(:inventory)
    item_params = attributes_for(:item).merge(inventory_id: inventory.id)

    patch item_url(@item), params: { item: item_params }, as: :json
    assert_response :success
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete item_url(@item), as: :json
    end

    assert_response :no_content
  end
end
