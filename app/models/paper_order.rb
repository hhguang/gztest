class PaperOrder < ActiveRecord::Base
  has_many :order_items ,:dependent=>:destroy

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
