class StaticPagesController < ApplicationController
  
  def home
  end

  def about
  end

  def budget
  	@budget = current_user.build_budget if signed_in?
  end
  
end
