class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  protect_from_forgery with: :exception
  include ApplicationHelper
end
