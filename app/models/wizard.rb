class Wizard
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :mobile, :selling, :buying, :price_range_start, :price_range_end

  validates_presence_of :name
  validates_presence_of :email

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end


end
