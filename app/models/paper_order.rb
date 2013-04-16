class PaperOrder < ActiveRecord::Base
  has_many :order_items ,:dependent=>:destroy

  ORDER_TYPES=[
    ["非毕业班",1],
    ["毕业班",2]
  ]

  ORDER_STATES=[
    ["可提交",true],
    ["关闭",false]
  ]

  def gather
    gather={:qxes=>[],s=>{}}
    
    Qx.all.each do |qx|
      qx.schools.each do |school|
        schoolarr=[]
        order=self.order_items.find_by_school_id(school)
        if order
          
        else

        end
        
      end
    end
  end
end
