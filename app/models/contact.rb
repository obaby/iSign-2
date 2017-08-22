class Contact < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :user

  def owner?(user)
    user.id == self.user_id
  end
end
