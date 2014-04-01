class CommitteesController < ApplicationController

def show
  # binding.pry
  @committee=Committee.find_by(id: params[:id].to_i)
  @members = @committee.electeds
end

end