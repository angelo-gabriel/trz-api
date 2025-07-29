require "test_helper"

class SurvivorTest < ActiveSupport::TestCase
  test "should not save survivor without name" do
    survivor = Survivor.new(age: 30, gender: "male", latitude: -5.0, longitude: -42.0)
    assert_not survivor.save, "Saved the survivor without a name"
  end

  test "should not save survivor without age" do
    survivor = Survivor.new(name: "John Doe", gender: "male", latitude: -5.0, longitude: -42.0)
    assert_not survivor.save, "Saved the survivor without an age"
  end

  test "should not save survivor without gender" do
    survivor = Survivor.new(name: "John Doe", age: 30, latitude: -5.0, longitude: -42.0)
    assert_not survivor.save, "Saved the survivor without a gender"
  end

  test "should save valid survivor" do
    survivor = Survivor.new(name: "John Doe", age: 30, gender: "male", latitude: -5.0, longitude: -42.0)
    assert survivor.save, "Could not save a valid survivor"
  end

  test "gender should be either 'male' or 'female'" do
    survivor = Survivor.new(name: "Test Gender", age: 30, latitude: -5.0, longitude: -42.0)

    survivor.gender = "other"
    assert_not survivor.save, "Saved survivor with invalid gender"

    survivor.gender = "male"
    assert survivor.save, "Could not save survivor with valid gender 'male'"

    survivor.gender = "female"
    assert survivor.save, "Could not save survivor with valid gender 'female'"
  end

  test "should have an associated inventory" do
    survivor = Survivor.create!(name: "Test Inventory", age: 30, gender: "male", latitude: -5.0, longitude: -42.0)
    assert_nil survivor.inventory

    inventory = Inventory.create!(survivor: survivor)
    assert_equal inventory, survivor.inventory
  end
end
