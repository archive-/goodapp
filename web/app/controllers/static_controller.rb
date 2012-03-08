class StaticController < ApplicationController
  def home
  end

  def about
    @active = :about
  end

  def search
  end

  def contact
    @active = :contact
  end

  def api
    @active = :api
  end
end
