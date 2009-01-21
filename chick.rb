Shoes.app :title => "Chick",
  :width => 310, :height => 500, :resize => false do
  
  stack :width => 120, :margin_left => 90 do
    image "bird.png", :margin_bottom => 60, :margin_top => 60
    edit_line :width => 120
    inscription "Username"
    edit_line :width => 120
    inscription "Password"
    button "Sign In"
  end
end