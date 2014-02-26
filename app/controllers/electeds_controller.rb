class ElectedsController < ApplicationController
  def index

    binding.pry
    unless defined?(@@electeds)
      @electeds = Elected.all
    else
      @electeds = @@electeds
    end
    @elected = Elected.new
  end
  def show
    @elected = Elected.find_by_id(params[:id].to_i)
  end

  def filter
    @@electeds = Elected.where(state: params[:state])
    redirect_to electeds_path
  end
end
