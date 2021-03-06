class UsersController < ApplicationController
  def show
    #いわゆるところのmypage
    respond_to do |format|
      format.html 
    end #end respond_to
  end #end show
  
  #GET    /users/:user_id/all(.:format)
  def all
    @data = { }
    @user = User.where( :name => params[:user_id] ).first

    if @user
      @data[:user] = @user
      @data[:documents] = @user.documents
      @data[:binders] = []
      @user.binders(:include => [:documents] ).each do |binder|
        @data[:binders] << { 
          :id => binder.id,
          :name => binder.name,
          :documents => binder.documents
        }
      end
      
      respond_to do |format|
        format.json {  render :json => { :result => 1, :data => @data}.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {  render :json => { :result => 0, :data => "User not found." }.to_json }
      end #end respond_to      
    end

  end
end
