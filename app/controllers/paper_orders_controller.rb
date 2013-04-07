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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paper_order }
    end
  end

  # GET /paper_orders/1/edit
  def edit
    @paper_order = PaperOrder.find(params[:id])
  end

  # POST /paper_orders
  # POST /paper_orders.xml
  def create
    @paper_order = PaperOrder.new(params[:paper_order])

    respond_to do |format|
      if @paper_order.save
        format.html { redirect_to(@paper_order, :notice => 'PaperOrder was successfully created.') }
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

    respond_to do |format|
      if @paper_order.update_attributes(params[:paper_order])
        format.html { redirect_to(@paper_order, :notice => 'PaperOrder was successfully updated.') }
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
end
