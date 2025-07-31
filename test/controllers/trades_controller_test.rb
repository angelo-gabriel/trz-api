require "test_helper"

class TradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proposer = create(:survivor)
    @recipient = create(:survivor)

    @proposer_item = create(:item, :fiji_water, inventory: @proposer.inventory, quantity: 10)
    @recipient_item = create(:item, :campbell_soup, inventory: @recipient.inventory, quantity: 10)
  end

  test "should perform a valid trade when values match" do
    post perform_trade_url, params: {
      proposer_survivor_id: @proposer.id,
      recipient_survivor_id: @recipient.id,
      proposer_offer: [{ item_id: @proposer_item.id, quantity: 6 }],
      recipient_offer: [{ item_id: @recipient_item.id, quantity: 7 }]
    }

    @proposer_item.reload
    @recipient_item.reload

    puts "Depois do post: proposer_item=#{@proposer_item.quantity}, recipient_item=#{@recipient_item.quantity}"

    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "Trade successful", json["message"]

    assert_equal 4, @proposer_item.quantity
    assert_equal 3, @recipient_item.quantity
  end

  test "should not trade with self" do
    post perform_trade_url, params: {
      proposer_survivor_id: @proposer.id,
      recipient_survivor_id: @proposer.id,
      proposer_offer: [{ item_id: @proposer_item.id, quantity: 1 }],
      recipient_offer: [{ item_id: @proposer_item.id, quantity: 1 }]
    }

    assert_response :unprocessable_entity
    assert_match "Cannot trade with yourself.", response.parsed_body["error"]
  end

  test "should fail if trade values don't match" do
    post perform_trade_url, params: {
      proposer_survivor_id: @proposer.id,
      recipient_survivor_id: @recipient.id,
      proposer_offer: [{ item_id: @proposer_item.id, quantity: 1 }],
      recipient_offer: [{ item_id: @recipient_item.id, quantity: 1 }]
    }

    assert_response :unprocessable_entity
    assert_match "Trade amounts do not match", response.parsed_body["error"]
  end

  test "fails with nonexistent item" do
    post perform_trade_url, params: {
      proposer_survivor_id: @proposer.id,
      recipient_survivor_id: @recipient.id,
      proposer_offer: [{ item_id: 9999, quantity: 1 }],
      recipient_offer: [{ item_id: @recipient_item.id, quantity: 2 }]
    }

    assert_response :unprocessable_entity
    assert_match "not found or insufficient quantity", response.parsed_body["error"]
  end
end
