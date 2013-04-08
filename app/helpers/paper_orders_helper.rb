module PaperOrdersHelper
  def bigbag(n)    
    return n>0 ? (n/30.0).round : 0
  end

  def smallbag(n)
    return (n>0 && (n % 30)!=0 && (n % 30)<15) ? 1 : 0
  end
end
