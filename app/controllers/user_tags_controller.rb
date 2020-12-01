class UserTagsController < ApplicationController
  def new
    @user_tag = UserTag.new
    topic_ids = params[:elementIds].split(',')
    @topics = topic_ids.map { |id| Topic.find(id) }
  end

  def create_tags
    current_user.user_tags.destroy_all
    tag_ids = params[:elementIds].split(',')
    tag_ids.each do |id|
      UserTag.create(user_id: current_user.id, tag_id: id.to_i)
    end
    redirect_to time_path
  end

  def edit
    @user_tag = UserTag.new
    @topics = Topic.all
  end

  def destroy
    user_tag = UserTag.find(params[:id])
    user_tag.destroy!

    redirect_to request.referrer
  end

  private

  def user_tag_params
    params.require(:user_tag).permit(:topic_id, :user_id)
  end
end
