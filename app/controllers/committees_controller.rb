class CommitteesController < ApplicationController

def show
  # binding.pry
  @committee=Committee.find_by(id: params[:id].to_i)
end

end