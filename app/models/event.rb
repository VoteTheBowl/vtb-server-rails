class Event < ApplicationRecord
  validates :name, :share_token, :host_token, :electoral_system, :choices, presence: true
  validates :host_token, format: { with: UUID_V4_REGEX }
  validates :share_token, format: { with: UUID_V4_REGEX }

  before_validation :create_tokens

  serialize :choices, type: Array, coder: JSON

  private
    def create_tokens
      if share_token.blank?
        self.share_token = SecureRandom.uuid
      end

      if host_token.blank?
        self.host_token = SecureRandom.uuid
      end
    end
end
