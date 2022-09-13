class Public::FightsController < ApplicationController
  
  # いいねする動作
  def create
    vision = Vision.find(params[:vision_id])
    @fight = current_user.fights.new(vision_id: vision.id)
    @fight.save
    render 'fight_btn'
  end

  # いいね外す動作
  def destroy
    vision = Vision.find(params[:vision_id])
    @fight = current_user.fights.find_by(vision_id: vision.id)
    @fight.destroy
    render 'fight_btn'
  end

end
