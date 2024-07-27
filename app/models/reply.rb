class Reply < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true
  belongs_to :admin_user , optional: true
end
