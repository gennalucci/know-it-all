class LikesController < ApplicationController

  def index
  end

  def create
    @user = current_user.id
    @article = params[:id]
    likes = {user_id: @user, article_id: @article}
    @like = Like.new(likes)
    @like.save!

    if @like.save
      redirect_to article_show_path(@article)
    else
      redirect_to dashboard_path
    end
  end

  def destroy
    @user = current_user
    @article = Article.find(params[:id])
    @like = Like.find_by(article_id: @article, user_id: @user)
    @like.destroy
    redirect_to article_show_path(@article)

  end
end
