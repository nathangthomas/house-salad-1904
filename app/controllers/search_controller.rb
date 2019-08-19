class SearchController < ApplicationController
  def index
    render locals: {
      facade: MemberSearchFacade.new(params[:state])
    }
  end
end
