class PaperOrdersController < ApplicationController
  before_filter :login_required,:require_admin
  # GET /paper_orders
  # GET /paper_orders.xml
  def index
    @paper_orders = PaperOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @paper_orders }
    end
  end

  # GET /paper_orders/1
  # GET /paper_orders/1.xml
  def show
    @paper_order = PaperOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paper_order }
    end
  end

  # GET /paper_orders/new
  # GET /paper_orders/new.xml
  def new
    @paper_order = PaperOrder.new
    @paper_orders = PaperOrder.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paper_order }
    end
  end

  # GET /paper_orders/1/edit
  def edit
    @paper_orders = PaperOrder.all
    @paper_order = PaperOrder.find(params[:id])
  end

  # POST /paper_orders
  # POST /paper_orders.xml
  def create
    @paper_order = PaperOrder.new(params[:paper_order])
    @paper_orders = PaperOrder.all
    respond_to do |format|
      if @paper_order.save
        format.html { redirect_to(paper_orders_url) }
        format.xml  { render :xml => @paper_order, :status => :created, :location => @paper_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paper_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /paper_orders/1
  # PUT /paper_orders/1.xml
  def update
    @paper_order = PaperOrder.find(params[:id])
    @paper_orders = PaperOrder.all
    respond_to do |format|
      if @paper_order.update_attributes(params[:paper_order])
        format.html { redirect_to(paper_orders_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paper_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /paper_orders/1
  # DELETE /paper_orders/1.xml
  def destroy
    @paper_order = PaperOrder.find(params[:id])
    @paper_order.destroy

    respond_to do |format|
      format.html { redirect_to(paper_orders_url) }
      format.xml  { head :ok }
    end
  end

  def gather
    @paper_order = PaperOrder.find(params[:id])
    @order_items=@paper_order.order_items.to_a
    @unorders=School.all-@order_items.collect{|i| i.school }
    @unorders.each do |school|
      @order_items<<@paper_order.order_items.build(:school_id=>school.id,
        :school_name=>school.name,
        :g1yw=>0,:g1sx=>0,:g1yy=>0,:g1wl=>0,:g1hx=>0,:g1sw=>0,:g1zz=>0,:g1ls=>0,:g1dl=>0,
        :g2yw=>0,:g2sxw=>0,:g2sxl=>0,:g2yy=>0,:g2wl=>0,:g2hx=>0,:g2sw=>0,:g2zz=>0,:g2ls=>0,:g2dl=>0,
        :g3yw=>0,:g3sxw=>0,:g3sxl=>0,:g3yy=>0,:g3wz=>0,:g3lz=>0,:g2w=>0,:g2l=>0,:g3w=>0,:g3l=>0
      )

    end
    @qxes=Qx.all 
    @orders_groups=@order_items.index_by{|item| item.school_id }
    @orders_qx=@order_items.group_by{ |item| item.school.qx_id }
  end

  def qx
    @paper_orders = PaperOrder.all
    @paper_order=PaperOrder.find_by_id(params[:id]) || @paper_orders.first
    if current_user.qx_id
    @qx=Qx.find(current_user.qx_id)
    @schools=@qx.schools
    @order_items=@paper_order.order_items.find_by_school_id(@schools.map{|s|s.id}).to_a
    @school_orders=@order_items.index_by{|item| item.school_id }
    else
      @schools=School.all
      @order_items = @paper_order.order_items
      @school_orders=@order_items.index_by{|item| item.school_id }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @paper_orders }
    end
  end

  def qx_orders
    @paper_orders = PaperOrder.all
    @paper_order=PaperOrder.find_by_id(params[:id]) || @paper_orders.first
    if current_user.qx_id
    @qx=Qx.find(current_user.qx_id)
    @schools=@qx.schools
    @order_items=@paper_order.order_items.find_by_school_id(@schools.map{|s|s.id}).to_a
    @unorders=@schools-@order_items.collect{|i| i.school }
    else
      @order_items = @paper_order.order_items
      @unorders=School.all-@order_items.collect{|i| i.school }
    end
  end
end
