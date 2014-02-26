class ElectedsController < ApplicationController
  def index

    @electeds = Elected.all
    @elected = Elected.new
  end
  def show
    @elected = Elected.find_by_id(params[:id].to_i)
  end

  def filter
    @electeds = Elected.where(state: params[:state])
    @elected = Elected.new
    render(:index)
  end
end
