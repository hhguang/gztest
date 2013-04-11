class OrdersController < ApplicationController
  def index
    @school=current_user.school
    @paper_orders=PaperOrder.all
#    @order_items=@school.order_items
  end

  def new
    @school=current_user.school
    @paper_order=PaperOrder.find(params[:paper_order_id])
    @order_item=@paper_order.order_items.build(:school_id=>@school.id)
  end

  def edit
    @school=current_user.school
    @order_item = OrderItem.find(params[:id]) if params[:id]
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
    @school=current_user.school
    @paper_order=PaperOrder.find(params[:order_item][:paper_order_id])
    respond_to do |format|
      if @order_item.save
        flash[:notice]= '订单已成功提交.'
        format.html { redirect_to(:action=>'show',:id=>@order_item) }
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
        
        format.html { redirect_to(:action=>'show',:id=>@order_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end
end
