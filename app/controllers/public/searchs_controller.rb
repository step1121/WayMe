class Public::SearchsController < ApplicationController

  def search
    @model = params[:model]
		@content = params[:content]
		if @model == 'user'
			@records = User.search_for(@content)
		elsif @model == 'vision'
			@records = Vision.search_for(@content)
		elsif @model == 'task'
			@records = Task.search_for(@content)
		end
  end
end
