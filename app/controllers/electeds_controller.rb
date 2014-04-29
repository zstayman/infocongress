class ElectedsController < ApplicationController
  def index
    unless logged_in?
      redirect_to root_path
    end
    @electeds = Elected.all.sort_by {|a| [a.house, a.last_name]}
    @elected = Elected.new
    @user = current_user
  end
  def show
    @elected = Elected.find_by_id(params[:id].to_i)
    if @elected.fec_id.nil?
      @local = nil
    else
      @local = HTTParty.get("http://transparencydata.com/api/1.0/aggregates/pol/#{@elected.fec_id}/contributors/local_breakdown.json?cycle=2014&apikey=#{ENV['SUNLIGHT_API']}")
    end
  end

  def filter
    binding.pry
    if params[:state] == "all"
      @electeds = Elected.all.sort_by {|a| [a.house, a.last_name]}
    else
      @electeds = Elected.where(state: params[:state])
    end
    @elected = Elected.new
    render(:index)
  end
end
