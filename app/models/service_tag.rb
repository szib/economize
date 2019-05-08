class ServiceTag < ApplicationRecord
  belongs_to :tag
  belongs_to :service
end
