class PullRequest < ApplicationRecord
  belongs_to :branch_in, class_name: "Branch"
  belongs_to :branch_out, class_name: "Branch"
end
