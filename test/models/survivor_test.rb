require "test_helper"

class SurvivorTest < ActiveSupport::TestCase
  setup do
    @survivor = build(:survivor)
  end

  test "should not save survivor without name" do
    @survivor.name = nil
    assert_not @survivor.save, "Saved the survivor without a name"
  end

  test "should not save survivor without age" do
    @survivor.age = nil
    assert_not @survivor.save, "Saved the survivor without an age"
  end

  test "should not save survivor without gender" do
    @survivor.gender = nil
    assert_not @survivor.save, "Saved the survivor without a gender"
  end

  test "should save valid survivor" do
    assert @survivor.save, "Could not save a valid survivor"
  end

  test "should create a survivor with a random gender" do
    survivor = create(:survivor)
    assert survivor.persisted?

    assert Survivor.genders.keys.map(&:to_s).include?(survivor.gender.to_s)
  end

  test "should have an associated inventory" do
    survivor = create(:survivor)
    inventory = create(:inventory, survivor: survivor)
    assert_equal inventory, survivor.inventory, "Survivor does not have the correct inventory"
  end
end
