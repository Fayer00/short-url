# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url, counter_cache: :clicks_count

  validates :browser, presence: true
  validates :platform, presence: true

  scope :daily_clicks, -> () { group('date(clicks.created_at)').count}
  scope :browser_clicks, -> () { group(:browser).count}
  scope :platform_clicks, -> () { group(:platform).count}

end
