class DashboardsController < ApplicationController
  def index
    @user = current_user
    # seeds articles to database based on user's topic preferences
    # and max read time (currently 2nd argument in CnnArticles.new)
    time = params[:time] || 10
    @articles = Article.joins(:tags).where("read_mins < ?", time)#.where(tags: {id: current_user.tags})
    # get all user's selected topics
    # @topics = @user.topics.all
    # get all the tags for each of the user's topics and put them into an array @tags
    # @tags = @topics.map do |topic|
    #   topic.tags.all
    # end
    @topics = @user.user_tags.map { |user_tag| user_tag.tag.topic }.uniq
  raise
  end

  def time
    # raise
  end

  def settings
  end

  def show
    @article = Article.find(params[:id])
    @existing_like = Like.find_by(user: current_user, article: @article)
  end

  def setup
    #display all topics
    @topics = Topic.all
  end

  def likes
  end
end
