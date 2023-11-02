# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  # include UuidModule
  primary_abstract_class

  Unit = 1000
end
