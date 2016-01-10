class SearchController < ApplicationController
  def index; end

  def query
    @q = params[:q]
    @results = resource.find(@q) unless @q.blank?
    respond_to do |format|
      format.html
      format.json { render json: @results }
    end
  end

  private

  def resource
    @resource ||= Search::Resource.new Rails.root.join('db', 'data.json')
  end
end
