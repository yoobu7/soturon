class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def import
    # fileはtmpに自動で一時保存される
    Item.import(params[:file])
    redirect_to root_url, notice: "add items"
  end


  def tag_cloud
      @tags = Item.tag_counts_on(:tags)
  end

  def item_params
    params.require(:item).permit(:name, :tag_list, :hurigana, :date, :bunrui, :bangou, :gozyuon, :picture)
  end

  def tag
    @items = Item.tagged_with(params[:tag_name])


  end
  # GET /items
  # GET /items.json
  def index

    @q = Item.search(params[:q])
    @items = @q.result.order("updated_at DESC").page(params[:page]).per(10)
    @tags = Item.tag_counts_on(:tags)

    #items = Item.all
    # @q = Item.search(params[:q])
    # @items = @q.result(distinct: true)
    # @items = Item.page(params[:page]).per(15)
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def item_params
      # params.require(:item).permit(:name, :hurigana, :date, :bunrui, :bangou, :gozyuon, :tag_list)
    # end
end
