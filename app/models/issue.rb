class Issue < ApplicationRecord
  belongs_to :user_create, class_name: :user
  belongs_to :user_assign, class_name: :user

end
