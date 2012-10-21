class BindersController < ApplicationController
  before_filter :authenticate_user!

  #バインダの作成
  # POST /users/:user_id/documents/:document_id
  def create
    @binder = Binder.new(:name => params[:name])
    @binder.users << current_user
    
    if @binder.save
      respond_to do |format|
        format.json {   render :json => {  :result => 0, :data => @binder }.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {   render :json => {  :result => 1, :message => 'Binder save faild.' }.to_json }
      end #end respond_to
    end

  end
  
  #既存のドキュメントをバインダに追加するアクション
  # POST /users/:user_id/documents/:document_id/:binder_id
  def add_documents
    @binder = Binder.where(:id => params[:binder_id] )
    @binder = @binder.users.select { |u| u.id == current_user.id }
    @binder << Document.where(:id => params[:document_id], :user_id => current_user.id )

    if @binder.save
      respond_to do |format|
        format.json {   render :json => {  :result => 0, :data => @binder }.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {   render :json => {  :result => 1, :message => 'Binder save faild.' }.to_json }
      end #end respond_to
    end
    
  end

  #ログイン済みユーザのバインダの一覧を取得
  # GET /binders
  def index
    @binders = current_user.binders
    respond_to do |format|
      format.json {   render :json => {  :result => 0, :data => @binders }.to_json }
    end #end respond_to
  end

end
