class ItemsController < ApplicationController
  #新しいアイテム(メモ)を作成する
  #POST /users/:user_id/documents/:document_id/items
  def create
    @document = Document.where( :id => params[:document_id] ).first
    if @document
      @document.items << Item.new( :content => params[:content] )
      if @document.save
        respond_to do |format|
          format.json { render :json => {   :result => 0, :data => @document }.to_json }
        end #respond_to
      else
        respond_to do |format|
          format.json {    render :json => {   :result => 1, :message => 'Document save faild.' }.to_json }
        end #end respond_to
      end
    else # if @document
      respond_to do |format|
        format.json {    render :json => {   :result => 1, :message => 'Document not found.' }.to_json }
      end #respond_to
    end # if @document
  end
end
