# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do

    subject do
      browsers = %w[IE Firefox Chrome Safari]
      platforms = %w[macOS Ubuntu Windows Other]
      create(:click, browser: browsers.sample, platform: platforms.sample)
    end

    it 'validates url_id is valid' do
      expect(subject).to be_valid
    end

    it 'validates browser is not null' do
      subject.browser = nil
      expect(subject).to_not be_valid
    end

    it 'validates platform is not null' do
      subject.platform = nil
      expect(subject).to_not be_valid
    end
  end
end
