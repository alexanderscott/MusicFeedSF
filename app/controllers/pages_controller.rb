class PagesController < ApplicationController

  def index
    @tweets = Tweet.order('created_at DESC').limit(100).all
    @articles = Article.order('published DESC').limit(100).all
  end

end
