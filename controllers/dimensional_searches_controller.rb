class DimensionalSearchesController < ApplicationController
  def show
    if params[:lvs].present?

      @sort = params[:sort]
      @width = params[:width]
      @width_max = params[:width_max]
      @arch = params[:arch]
      @arch_max = params[:arch_max]
      @lvs = params[:lvs]
      @se_dim = params[:se_dim]
      @se_max = params[:se_max]
      @le_dim = params[:le_dim]
      @le_max = params[:le_max]
      @location = params[:location]

      @springs = DimensionalSearch.new(params).springs.paginate(page: params[:page],
                                                            per_page: 50)   # .order(@sort)
    else
      @springs = TriangleSpring.none
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
