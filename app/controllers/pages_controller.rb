class PagesController < ApplicationController
  def home
    @inquiry = Inquiry.new
  end
end
