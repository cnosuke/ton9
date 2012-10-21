class UsersController < ApplicationController
  def show
    #いわゆるところのmypage
    respond_to do |format|
      format.html 
    end #end respond_to
  end #end show
end
