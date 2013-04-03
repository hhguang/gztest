class OrderItem < ActiveRecord::Base
  belongs_to :paper_order
  belongs_to :school
end
