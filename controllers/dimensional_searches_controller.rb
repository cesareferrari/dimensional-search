class DimensionalSearchesController < ApplicationController
  def show
    if params[:lvs].present?
      @springs = DimensionalSearch.new(params).springs.paginate(page: params[:page],
                                                                per_page: 50)
    else
      @springs = TriangleSpring.none
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
