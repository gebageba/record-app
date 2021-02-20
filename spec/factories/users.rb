# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end
