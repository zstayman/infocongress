class ElectedsController < ApplicationController
  def index
    @electeds = Elected.all
  end
  def show
    @elected = Elected.find(params[:id])
  end
end
