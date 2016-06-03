class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy] 
  before_action :authenticate_user!, except: [:show, :index]
  before_filter :require_permission, only: [:edit, :delete]

  # GET /stores
  # GET /stores.json
  def index
    if params[:search]
      @par = params[:search]
      @str = "%#{@par.gsub('%', '\%').gsub('_', '\_')}%"
      @stores = Store.find_by_sql(["SELECT * FROM stores WHERE name LIKE ? ", @str])   
    else
      @stores = Store.all
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store.update_visits_count
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = current_user.stores.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'La Tienda fue creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'La Tienda fue actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'La Tienda fue eliminada satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:user_id, :name, :category, :description, :logo, :background_image)
    end

    def require_permission
      if current_user != Store.friendly.find(params[:id]).user
        redirect_to root_path
      #Or do something else here
      end
    end
end
