class OrdersController < ApplicationController
  def index
    @school=current_user.school
    @paper_order=PaperOrder.find_by_current(1)
    @order_item=@paper_order.order_items.find_by_school_id(@school.id) || @paper_order.order_items.build(:school_id=>@school.id)
  end

  def show
    @order_item = OrderItem.find(params[:id]) if params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order_item }
    end
  end

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
end
