class TradesController < ApplicationController
  def perform_trade
    proposer_survivor_id = params[:proposer_survivor_id]
    recipient_survivor_id = params[:recipient_survivor_id]
    proposer_offer = params[:proposer_offer] || []
    recipient_offer = params[:recipient_offer] || []

    proposer_survivor = Survivor.find(proposer_survivor_id)
    recipient_survivor = Survivor.find(recipient_survivor_id)

    proposer_inventory = proposer_survivor.inventory
    recipient_inventory = recipient_survivor.inventory

    if proposer_survivor.id == recipient_survivor.id
      render json: { error: "Cannot trade with yourself." }, status: :unprocessable_entity
      return
    end

    items_to_transfer = { proposer: [], recipient: [] }
    proposer_total_price = 0
    recipient_total_price = 0

    # Process proposer's items
    proposer_offer.each do |offer|
      item_to_transfer = proposer_inventory.items.find_by(id: offer[:item_id])
      quantity_offered = offer[:quantity].to_i

      unless item_to_transfer && item_to_transfer.quantity >= quantity_offered && quantity_offered > 0
        render json: { error: "Item #{offer[:item_id]} not found or insufficient quantity in proposer inventory." }, status: :unprocessable_entity
        return
      end
      
      items_to_transfer[:proposer] << { item_object: item_to_transfer, quantity: quantity_offered }
      proposer_total_price += item_to_transfer.price * quantity_offered
    end

    # Process recipient's items
    recipient_offer.each do |offer|
      item_to_transfer = recipient_inventory.items.find_by(id: offer[:item_id])
      quantity_offered = offer[:quantity].to_i

      unless item_to_transfer && item_to_transfer.quantity >= quantity_offered && quantity_offered > 0
        render json: { error: "Item #{offer[:item_id]} not found or insufficient quantity in recipient inventory." }, status: :unprocessable_entity
        return
      end

      items_to_transfer[:recipient] << { item_object: item_to_transfer, quantity: quantity_offered }
      recipient_total_price += item_to_transfer.price * quantity_offered
    end

    if proposer_total_price != recipient_total_price
      render json: { error: "Trade amounts do not match. Proposer total: #{proposer_total_price}, Recipient total: #{recipient_total_price}" }, status: :unprocessable_entity
      return
    end

    ActiveRecord::Base.transaction do
      transfer_to_recipient = []
      transfer_to_proposer = []

      items_to_transfer[:proposer].each do |transfer|
        proposer_item = transfer[:item_object]
        quantity_to_move = transfer[:quantity]

        proposer_item.quantity -= quantity_to_move
        proposer_item.save!

        recipient_item_entry = recipient_inventory.items.find_or_initialize_by(name: proposer_item.name)
        recipient_item_entry.quantity ||= 0
        recipient_item_entry.price ||= proposer_item.price
        recipient_item_entry.quantity += quantity_to_move
        recipient_item_entry.save!

        transfer_to_recipient << { id: proposer_item.id, name: proposer_item.name, price: proposer_item.price, quantity: quantity_to_move }
      end

      items_to_transfer[:recipient].each do |transfer|
        recipient_item = transfer[:item_object]
        quantity_to_move = transfer[:quantity]

        recipient_item.quantity -= quantity_to_move
        recipient_item.save!

        proposer_item_entry= proposer_inventory.items.find_or_initialize_by(name: recipient_item.name)
        proposer_item_entry.quantity ||= 0
        proposer_item_entry.price ||= recipient_item.price
        proposer_item_entry.quantity += quantity_to_move
        proposer_item_entry.save!

        transfer_to_proposer << { id: recipient_item.id, name: recipient_item.name, price: recipient_item.price, quantity: quantity_to_move }
      end

      render json: {
        message: "Trade successful",
        proposer_survivor_id: proposer_survivor.id,
        recipient_survivor_id: recipient_survivor.id,
        items_transferred_to_proposer: transfer_to_proposer,
        items_transferred_to_recipient: transfer_to_recipient,
        proposer_total_price: proposer_total_price,
        recipient_total_price: recipient_total_price
      }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Failed to trade (validation): #{e.message}" }, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: "Resource not found (survivor or item type): #{e.message}" }, status: :not_found
    rescue => e
      render json: { error: "Unexpected error during trade: #{e.message}" }, status: :internal_server_error
    end
  end
end

