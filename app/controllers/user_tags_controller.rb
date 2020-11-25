class UserTagsController < ApplicationController
  def new
    @user_tag = UserTag.new
    topic_ids = params[:topicIds].split(',')
    @topics = topic_ids.map { |id| Topic.find(id) }
    raise
  end

  def create
    # user_topic = UserTopic.new(user_topic_params)
    # user_topic.save

    # redirect_to user_topic_path(user_topic)
  end

  def destroy
    user_topic = UserTopic.find(params[:id])
    user_topic.destroy

    redirect_to user_topic_path
  end

  private

  def user_topic_params
    params.require(:user_topic).permit(:topic_id, :user_id)
  end
end
