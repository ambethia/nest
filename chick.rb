require 'tk'

class Chick
  attr_reader :root

  def initialize
    @root = TkRoot.new {
      title "Chick"
      minsize 310, 500
    }
  end
  
end

Chick.new
Tk.mainloop
