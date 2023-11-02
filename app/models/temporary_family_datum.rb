# frozen_string_literal: true

class TemporaryFamilyDatum < ApplicationRecord
  belongs_to :approval_request
end
