# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    # recent 10 short urls
    @url = Url.new
    @urls = Url.latest.limit(10)
  end

  def create
    url = ShortUrl::Creator.new(url: url_params[:original_url])
    result = url.new_shorty
    status = result[:errors].present? ? :bad_request : :ok
    if status == :bad_request
      flash[:error] = result[:errors]
    else
      flash[:success] = "New Short URL created successfully"
    end
    redirect_to urls_path
  end

  def show
    @url = Url.find_by(short_url: params[:url])
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found and return if @url.nil?

    @click = Click.where(url_id: @url.id)
    @daily_clicks = @click.daily_clicks.to_a.map{|m| [m.first.strftime('%d').to_i.to_s, m.last]}
    @browser_clicks = @click.browser_clicks.to_a
    @platform_clicks = @click.platform_clicks.to_a
  end

  def visit
    # params[:short_url]
    @url = Url.find_by(short_url: params[:short_url])
    click = Click.new(url: @url, browser: browser.name, platform: browser.platform.name)
    if click.save
      redirect_to @url.original_url
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
  end
end
