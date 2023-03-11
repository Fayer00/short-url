# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}
  validates :original_url, presence: true
  validates :short_url, presence: true, length: { is: 5 }, uniqueness: true

  has_many :clicks

  scope :latest, -> { order(created_at: :desc) }

end
