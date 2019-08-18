class ReposController < ApplicationController

  def index
  end

  def search
    @repos, @links = RepoQuerySearch.new(search_params[:q]).call
  end

  def paginate
    @repos, @links = RepoPaginationSearch.new(search_params[:url]).call
    render :search
  end

  private

  def search_params
    params.require(:repo_query).permit(:q, :url)
  end
end
