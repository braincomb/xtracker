class ApplicationController < ActionController::Base
  before_filter :init

  def init
    @start_time = Time.now
  end
end
