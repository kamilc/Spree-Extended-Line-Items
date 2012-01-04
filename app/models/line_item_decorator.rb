LineItem.class_eval do
  validates :quantity, :numericality => true

  after_validation do
    # check if there is a problem with quantity field
    if self.errors.messages.has_key?(:quantity) and self.errors.messages[:quantity].include?(I18n.t("validation.must_be_int"))
      self.errors.messages[:quantity].delete(I18n.t("validation.must_be_int"))
    end
    puts self.errors.to_s
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