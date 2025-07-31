require "test_helper"

class ItemTest < ActiveSupport::TestCase
  setup do
    @item = build(:item)
  end

  test "should create a valid item" do
    item = build(:item)
    assert item.valid?, "Expected generic item to be valid, but got errors: #{item.errors.full_messages}"

    assert item.save
    assert item.persisted?, "Expected item to be persisted after saving"
  end

  test "should create unique names for items" do
    item1 = create(:item)
    item2 = create(:item)
    assert_not_equal item1.name, item2.name, "Expected item names to be unique"
  end
end
