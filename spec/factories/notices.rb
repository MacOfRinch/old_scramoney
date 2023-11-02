# frozen_string_literal: true

FactoryBot.define do
  factory :notice do
    title { 'MyString' }
    content { 'MyText' }
  end
end
