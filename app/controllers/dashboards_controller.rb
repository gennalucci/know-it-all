class DashboardsController < ApplicationController
  def index
  end

  def settings
  end

  def show
  end

  def setup
    #display all topics
    @topics = Topic.all
  end

  def likes
  end
end
