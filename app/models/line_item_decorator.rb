LineItem.class_eval do

  # validates :quantity, :numericality => true

  after_validation do
    # check if there is a problem with quantity field
    # TODO: Polepszyć to
    self.errors.messages.delete(:quantity)
  end

  before_validation do
    _validate_callbacks.reject! do |f| 
      f.raw_filter.class == ActiveModel::Validations::NumericalityValidator 
    end
  end

  def valid?(context = false)
    errors.empty?
  end

  # round quantity to 
  before_save do
    round_quantity
  end

  private

  def round_quantity
    position = position_by_round(self.product.round)
    if position > 0
      self.quantity = ((self.quantity*(10**position)).to_i.to_f)/(10**position)
    else
      self.quantity = self.quantity.to_i.to_f
    end
  end

  def position_by_round(r)
    position = 0
    round = r
    while round.to_i.to_f != round
      round *= 10
      position += 1
    end
    position
  end
end