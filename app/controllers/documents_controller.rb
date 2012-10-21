class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  # 新しいドキュメントを作成する
  # POST /users/:user_id/documents
  def create
    @document = Document.new(params)
    if @dosument.save
      respond_to do |format|
        format.json {  render :json => { :result => 0, :data => @document }.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {  render :json => { :result => 1, :message => 'Document create faild.' }.to_json }
      end #end respond_to
    end
  end

  # 新しいドキュメントを作成する
  # POST /users/:user_id/documents
  def index
    p params[:user_id]
    @user = User.where( :name => params[:user_id] ).first
    if @user
      @documents = Document.where(:user_id => @user.id )
      respond_to do |format|
        format.json {  render :json => { :result => 0, :data => @documents }.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {  render :json => { :result => 1, :message => 'User not found.' }.to_json }
      end #end respond_to
    end
  end

end
