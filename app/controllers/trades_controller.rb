class TradesController < ApplicationController
  def perform_trade
    proposer_survivor_id = params[:proposer_survivor_id]
    recipient_survivor_id = params[:recipient_survivor_id]
    proposer_item_id = params[:proposer_item_id]
    recipient_item_id = params[:recipient_item_id]

    proposer_survivor = Survivor.find_by(id: proposer_survivor_id)
    recipient_survivor = Survivor.find_by(id: recipient_survivor_id)
    proposer_item = Item.find(proposer_item_id)
    recipient_item = Item.find(recipient_item_id)

    proposer_inventory = proposer_survivor.inventory
    recipient_inventory = recipient_survivor.inventory

    unless proposer_item.inventory_id == proposer_inventory.id
      render json: { error: "Item #{proposer_item.name} dos not belong to proposer." }, status: :unprocessable_entity
      return
    end

    unless recipient_item.inventory_id == recipient_inventory.id
      render json: { error: "Item #{recipient_item.name} dos not belong to recipient." }, status: :unprocessable_entity
      return
    end

    if proposer_survivor.id == recipient_survivor.id
      render json: { error: "Cannot trade with yourself." }, status: :unprocessable_entity
      return
    end

    ActiveRecord::Base.transaction do
      proposer_item.update!(inventory: recipient_inventory)
      recipient_item.update!(inventory: proposer_inventory)
      render json: {
        message: "Trade successful",
        exchanged_items: {
          proposer_item: { item_id: proposer_item.id, owner_id: recipient_survivor.id },
          recipient_item: { item_id: recipient_item.id, owner_id: proposer_survivor.id }
        }
      }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Failed to trade: #{e.message}" }, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: "Resource not found: #{e.message}" }, status: :not_found
    rescue => e
      render json: { error: "Unexpected error: #{e.message}" }, status: :internal_server_error
    end
  end
end

