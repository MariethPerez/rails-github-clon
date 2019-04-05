class PullRequest < ApplicationRecord
  belongs_to :branch_in, class_name: :user
  belongs_to :branch_out, class_name: :user
end
