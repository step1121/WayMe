class Public::SearchsController < ApplicationController

  def search_user
		@content = params[:content]
		@records = User.search_for(@content)
  end

  def search_vision
		@content = params[:content]
		@records = Vision.search_for(@content)
		@visions_still = @records.where(finish_status: false)
    @visions_finish = @records.where(finish_status: true)
  end
end
