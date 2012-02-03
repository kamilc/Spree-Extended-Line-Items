InventoryUnit.class_eval do
  def self.destroy_units(order, variant, quantity)
    variant_units = order.inventory_units.group_by(&:variant_id)
    return unless variant_units.include? variant.id

    variant_units = variant_units[variant.id].sort_by(&:state)

    quantity.to_i.times do
      inventory_unit = variant_units.shift
      inventory_unit.destroy
    end
  end

  def self.create_units(order, variant, sold, back_order)
    return if back_order > 0 && !Spree::Config[:allow_backorders]


    shipment = order.shipments.detect {|shipment| !shipment.shipped? }

    sold.to_i.times { order.inventory_units.create(:variant => variant, :state => "sold", :shipment => shipment) }
    back_order.to_i.times { order.inventory_units.create(:variant => variant, :state => "backordered", :shipment => shipment) }
  end


end