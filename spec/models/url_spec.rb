# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  subject do
    create(:url)
  end

  describe 'validations' do
    it 'validates is a valid Url' do
      expect(subject).to  be_valid
    end

    it 'validates original URL is valid URL' do
      # add later
    end



    it 'validates short URL is present' do
      subject.short_url = nil
      expect(subject).to_not be_valid
    end

    it 'validates short URL length' do
      subject.short_url = [*'A'..'Z'].sample(6).join
      expect(subject).to be_invalid
    end

    it 'Validates short URL uniqness' do
      new_url = Url.new(original_url: 'http://www.example.com', short_url: subject.short_url)
      expect(new_url.valid?).to be false
    end
  end
end
