class Ballot < ApplicationRecord
  belongs_to :event
  validates_associated :event
  validates :voter_name, uniqueness: { scope: :event, message: "unique voters per event" }
  validates :token, :voter_name, :event, presence: true
  validates :token, uniqueness: true
  validates :token, format: { with: UUID_V4_REGEX }

  before_validation :create_token

  private
    def create_token
      if token.blank?
        self.token = SecureRandom.uuid
      end
    end
end
