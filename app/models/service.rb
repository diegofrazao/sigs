class Service < ApplicationRecord
  validates :descricao, :valor ,presence: true
end
