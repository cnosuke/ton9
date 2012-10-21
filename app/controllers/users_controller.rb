class UsersController < ApplicationController
  def show
    #いわゆるところのmypage
    respond_to do |format|
      format.html 
    end #end respond_to
  end #end show
  
  def all
    #GET /users/USER_NAME/all.json
  end
end
