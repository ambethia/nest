Shoes.setup { gem "twitter" }
require "twitter"

Shoes.app :title => "Chick",
  :width => 310, :height => 500, :resizable => false do
  
  def login
    stack :width => 120, :margin_left => 90 do
      image "bird.png", :margin_bottom => 60, :margin_top => 60
      @user = edit_line :width => 120
      inscription "Username"
      @pass = edit_line :width => 120, :secret => true
      inscription "Password"
      button "Sign In" do
        @login.remove
        timeline
      end
    end
  end

  def timeline
    @twitter = Twitter::Base.new(@user.text, @pass.text)
    @twitter.verify_credentials
    stack do
      @twitter.timeline.each do |status|
        flow :margin => 5 do
          stack :width => 48 do
            image status.user.profile_image_url
          end
          stack :width => "-48" do
            para status.user.name
            para status.text
          end
        end
      end
    end
  rescue Twitter::CantConnect => e
    @login = login
    alert(e)
  end

  @login = login
end