class ItemsController < ApplicationController
  #新しいアイテム(メモ)を作成する
  #POST /users/:user_id/documents/:document_id/items
  def create
    @document = Document.where( :id => params[:document_id] ).first
    unless params[:content].present?
      params[:content] = ""
    end

    # 親アイテムが指定された場合あるかどうかチェック
    if params[:parent_item_id].present?
      @parent_item = Item.where(:id => params[:parent_item_id]).first
      unless @parent_item.present?
        respond_to do |format|
          format.json { render :json => {   :result => 0, :message => "Parent item not found." }.to_json }
        end
        return
      end
    end

    if @document
      @item = Item.new( :content => params[:content] )
      if @parent_item.present?
        unless @parent_item.child_items << @item
          respond_to do |format|
            format.json { render :json => {   :result => 1, :data => "Item save faild." }.to_json }
          end
        end
      end
      if @document.items << @item
        respond_to do |format|
          format.json { render :json => {   :result => 1, :data => @item }.to_json }
        end #respond_to
      else
        respond_to do |format|
          format.json {    render :json => {   :result => 0, :message => 'Document save faild.' }.to_json }
        end #end respond_to
      end
    else # if @document
      respond_to do |format|
        format.json {    render :json => {   :result => 0, :message => 'Document not found.' }.to_json }
      end #respond_to
    end # if @document
  end
end
