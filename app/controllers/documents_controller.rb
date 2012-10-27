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

  def get_parent_item(result,item)
    parent_item = result.select{ |e| e[:item].id == item.parent_item_id }.first

    if parent_item.present?
      # 一世代目の子供のケース
      return parent_item
    end

    # 今よりも下の世代の子供達を探し出す
    children_s = result.map{ |e| e[:children] }.flatten

    # 子供達のうち、itemの親となる子供を人肉捜索する
    parent_item = children_s.select{ |e| e[:item].id == item.parent_item_id }.first

    if parent_item.present?
      # 親となる子供が見つかればそれをreturnする
      return parent_item      
    else
      # 見つからない場合はさらに深い世代に親となりうる子供を人肉捜索にいく
      return get_parent_item(children_s,item)
    end
  end
  
  def get_item_tree(doc)
    items = doc.items
    result = []
    items.each do |item|
      if item.parent_item_id.present?
        parent_item = get_parent_item(result,item)
        parent_item[:children] << { :item => item, :children => [] }
      else
        result << {
          :item => item,
          :children => []
        }
      end
    end
    return result.reverse
  end
  
  # GET    /users/:user_id/documents/:id(.:format)
  def show
    @document = Document.where(:id => params[:id]).first

    if @document
      # current_user が所持者 or バインダーに追加されたuser => true
      if @document.user.id == current_user.id || @document.binder.users.pluck(:user_id).include?(current_user.id)

        @items = get_item_tree(@document)

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
