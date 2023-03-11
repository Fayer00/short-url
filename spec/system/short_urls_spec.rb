# frozen_string_literal: true

require 'rails_helper'
require 'webdrivers'

# WebDrivers Gem
# https://github.com/titusfortner/webdrivers
#
# Official Guides about System Testing
# https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html

RSpec.describe 'Short Urls', type: :system do
  before do
    driven_by :selenium, using: :chrome
    # If using Firefox
    # driven_by :selenium, using: :firefox
    #
    # If running on a virtual machine or similar that does not have a UI, use
    # a headless driver
    # driven_by :selenium, using: :headless_chrome
    # driven_by :selenium, using: :headless_firefox
  end

  describe 'index' do
    before do
      create_list(:url, 10)
    end

    it 'shows a list of short urls' do
      visit root_path
      expect(page).to have_text('HeyURL!')
      # expect page to show 10 urls
      expect(page).to have_selector(%(a[id="short-url"]), count: 10)
    end
  end

  describe 'show' do
    before do
      @url = create(:url)
    end

    it 'shows a panel of stats for a given short url' do
      visit url_path(@url.short_url)
      # expect page to show the short url
      expect(page).to have_text(@url.short_url)
      expect(page).to have_text(@url.original_url)
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit url_path('NOTFOUND')
        # expect page to be a 404
        expect(page).to have_text("The page you were looking for doesn't exist.")
      end
    end
  end

  describe 'create' do
    context 'when url is valid' do
      it 'creates the short url' do
        visit root_path
        fill_in "url_original_url", with: 'http://www.google.com'
        click_on 'short-url'
        expect(page).to have_text('New Short URL created successfully')
      end

      it 'redirects to the home page' do
        visit root_path
        fill_in "url_original_url", with: 'http://www.google.com'
        click_on 'short-url'
        expect(page).to have_current_path("/urls")
      end
    end

    context 'when url is invalid' do
      it 'does not create the short url and shows a message' do
        visit root_path
        fill_in "url_original_url", with: 'asdafasdf'
        click_on 'short-url'
        expect(page).to have_text('Invalid URL:')
      end

      it 'redirects to the home page' do
        visit root_path
        fill_in "url_original_url", with: 'asdafasdf'
        click_on 'short-url'
        expect(page).to have_current_path("/urls")
      end
    end
  end

  describe 'visit' do
    before do
      @url = create(:url)
    end

    it 'redirects the user to the original url' do
      get visit_path(@url.short_url)
      expect(response).to redirect_to(@url.original_url)
      # add more expections
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit visit_path('NOTFOUND')
        # expect page to be a 404
        expect(page).to have_text("The page you were looking for doesn't exist.")
      end
    end
  end
end
