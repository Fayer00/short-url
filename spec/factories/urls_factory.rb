# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    short_url { [*'A'..'Z'].sample(5).join }
    sequence(:original_url) { |i| "https://www.goole.con/search?=#{i}" }
  end
end
