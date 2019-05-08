class PriceRecord < ApplicationRecord
    belongs_to :service
    validates :effective_from, presence: true
    validates :service_id, presence: true

  


end
