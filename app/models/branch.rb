class Branch < ApplicationRecord
  belongs_to :repository
  belongs_to :user
  has_many :pull_requets
end
