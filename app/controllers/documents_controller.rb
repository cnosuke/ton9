class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  # 新しいドキュメントを作成する
  # POST /users/:user_id/documents
  def create
    @document = Document.new(params[:document])
    @document.user = current_user
    if @document.save
      respond_to do |format|
        format.json {  render :json => { :result => 1, :data => @document }.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {  render :json => { :result => 0, :message => 'Document create faild.' }.to_json }
      end #end respond_to
    end
  end

  # ユーザが所有するドキュメント一覧を返す
  # GET /users/:user_id/documents
  def index
    p params[:user_id]
    @user = User.where( :name => params[:user_id] ).first
    if @user
      @documents = Document.where(:user_id => @user.id )
      respond_to do |format|
        format.json {  render :json => { :result => 1, :data => @documents }.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {  render :json => { :result => 0, :message => 'User not found.' }.to_json }
      end #end respond_to
    end
  end

end
