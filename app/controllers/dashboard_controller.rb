class DashboardController < ApplicationController
  def index
    @user = current_user
    # seeds articles to database based on user's topic preferences
    # and max read time (currently 2nd argument in CnnArticles.new)
    @articles = CnnArticles.new(@user, 10)
    raise
    # get all user's selected topics
    @topics = @user.topics.all
    # get all the tags for each of the user's topics and put them into an array @tags
    @tags = @topics.map do |topic|
      topic.tags.all
    end



  end

  def settings
  end

  def show
  end

  def likes
  end
end
