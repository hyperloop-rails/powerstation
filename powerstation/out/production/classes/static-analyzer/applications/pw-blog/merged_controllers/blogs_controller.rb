class BlogsController < ApplicationController
   include BlogsHelper
   include ActionView::Helpers::UrlHelper
   respond_to :js, :json, :html
   def index
      Rails.logger.debug "----Out #{params}"
      render :nothing => true
      [1].each do
        	user = User.first
      	user.blogs.size
      	user.blogs.count
      end
   end
   def show
      size = 5
      @users = nil
      for i in 1..5
         @users = User.limit(size)
         @users = User.limit(size)
         link_to 'test', 'blogs/show'
      end      
      a = 5
      if a == 5
         @blogs = Blog.paginate(:page => params[:page], :per_page => 5) 
      end         
      b = Blog.first 
      b.id
      Blog.find(b.id)
      b.reload
      render 'show'
 link_to Blog.where(category: 'admin').count 
 link_to User.count 
 render partial: 'user'
 @users.each do |user| 
 user.name
 user.nickname
 user.address
 user.created_at
 end 
 render partial: 'blogs/blog'
 @blogs.each do |blog| 
 blog.title 
 blog.created_at 
 blog.text 
 end 
 will_paginate @blogs 
 render partial: 'blogs/date'
 Time.zone.now 
 link_to 'test' 
      b.reload
   end
end
