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

  def get_children(arg)
    return arg.map do |item|
      { :item => item, :children => get_children(item.child_items) }
    end    
  end

  # GET    /users/:user_id/documents/:id(.:format)
  def show
    @document = Document.where(:id => params[:id]).first

    if @document
      # current_user が所持者 or バインダーに追加されたuser => true
      if @document.user.id == current_user.id || @document.binder.users.pluck(:user_id).include?(current_user.id)

        @items = @document.items.reverse
        @items = get_children(@items)

        respond_to do |format|
          format.json {  render :json => { :result => 1, :data => { :document => @document, :items => @items} }.to_json }
        end #end respond_to
      else
        respond_to do |format|
          format.json {  render :json => { :result => 0, :message => 'You are not authorized.'}.to_json }
        end #end respond_to
      end
    else # if @document
      respond_to do |format|
        format.json {  render :json => { :result => 0, :message => 'Document not found.'}.to_json }
      end #end respond_to
    end
  end

  # DELETE /users/:user_id/documents/:id(.:format)
  def destroy
    @document = Document.where(:id => params[:id], :user_id => current_user.id ).first

    if @document.destroy
      respond_to do |format|
        format.json {  render :json => { :result => 1, :message => 'Succesfully destroied.'}.to_json }
      end #end respond_to      
    else
      respond_to do |format|
        format.json {  render :json => { :result => 0, :message => 'Document destroy faild.'}.to_json }
      end #end respond_to
    end

  end

end
