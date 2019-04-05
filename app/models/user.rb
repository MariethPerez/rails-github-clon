class User < ApplicationRecord
    has_many :repositories
    has_many :branches
    has_many :issues
end
