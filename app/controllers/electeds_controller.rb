class ElectedsController < ApplicationController
  def index
    @electeds = Elected.all
  end
  def show
    @elected = Elected.find_by_id(params[:id].to_i)
  end
end
