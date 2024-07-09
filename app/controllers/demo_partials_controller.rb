class DemoPartialsController < ApplicationController
  def new
    @zone = "Zone New action"
    @date = Time.zone.today
  end

  def edit
    @zone = "Zone Edit action"
    @date = Time.zone.today - 4
  end

  before_action :set_locale
  def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
