class Public::SearchsController < ApplicationController
  before_action :authenticate_user!

  # ユーザー検索
  def search_user
		@content = params[:content]
		@records = User.search_for(@content)
  end

  # ビジョン検索
  def search_vision
		@content = params[:content]
		@records = Vision.search_for(@content)
		@visions_still = @records.still
    @visions_finish = @records.finish
  end
end
