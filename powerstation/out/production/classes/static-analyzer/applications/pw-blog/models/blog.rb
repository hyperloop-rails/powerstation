class Blog < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    def self.retrieve(bid)
        self.where(id: bid).first
    end
    def self.blogByCategory(category)
        con = []
        blogs = extractBlogs(category)
    end
    def self.extractBlogs(category=nil)
        blogs = nil
        ids = [1,2,3]
        ids.each do |id|
            Blog.find(id)
        end
        if category
            blogs = Blog.where(category: category).reload.reject {|blog| blog.user_id == nil}
        end
        return blogs
    end
end
