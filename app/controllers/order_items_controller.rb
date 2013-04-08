class OrderItemsController < ApplicationController
  before_filter :login_required,:require_admin
  before_filter :find_paper_order
  # GET /order_items
  # GET /order_items.xml
  def index
    @order_items = @paper_order.order_items
    @unorders=School.all-@order_items.collect{|i| i.school }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @order_items }
    end
  end

  # GET /order_items/1
  # GET /order_items/1.xml
  def show
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order_item }
    end
  end

  # GET /order_items/new
  # GET /order_items/new.xml
  def new
    @order_item = OrderItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order_item }
    end
  end

  # GET /order_items/1/edit
  def edit
    @order_item = OrderItem.find(params[:id])
  end

  # POST /order_items
  # POST /order_items.xml
  def create
    @order_item = OrderItem.new(params[:order_item])

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to(@order_item, :notice => 'OrderItem was successfully created.') }
        format.xml  { render :xml => @order_item, :status => :created, :location => @order_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /order_items/1
  # PUT /order_items/1.xml
  def update
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to(@order_item, :notice => 'OrderItem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.xml
  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to(paper_order_order_items_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def find_paper_order
    @paper_order=PaperOrder.find(params[:paper_order_id])
  end
end
