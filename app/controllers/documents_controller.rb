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
  # GET /users/:user_id/documents
  def index
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

  def show
    @document = Document.where(:id => params[:id]).first
    if @document
      @items = @document.items
      respond_to do |format|
        format.json {  render :json => { :result => 0, :data => { :document => @document, :items => @items} }.to_json }
      end #end respond_to
    else
      respond_to do |format|
        format.json {  render :json => { :result => 1, :message => 'Document not found.'}.to_json }
      end #end respond_to
    end
  end

end
