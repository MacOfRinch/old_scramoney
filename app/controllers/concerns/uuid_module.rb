module UuidModule
  extend ActiveSupport::Concern

  included do
    before_create :generate, if: -> { has_attribute?(:id) }
  end

  def generate
    self.id ||= loop do
      uuid = SecureRandom.uuid
      break uuid unless self.class.exists?(id: uuid)
    end
  end
end