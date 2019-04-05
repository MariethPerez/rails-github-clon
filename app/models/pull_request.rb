class PullRequest < ApplicationRecord
  belongs_to :branch_in, class_name: 'User'
  belongs_to :branch_out, class_name: 'User'
end
