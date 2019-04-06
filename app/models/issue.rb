class Issue < ApplicationRecord
  belongs_to :user_create, class_name: "User"
  belongs_to :user_assign, class_name: "User"
  belongs_to :repository
end
