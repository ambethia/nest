Shoes.setup { gem "twitter" }
require "twitter"

Shoes.app :title => "Chick",
  :width => 310, :height => 500, :resizable => false do
  
  background gray(0.3)
  style(Para, :size => 10)
  style(Link, :underline => false, :stroke => gray(0.3))
  
  def login
    stack :width => 135, :left => 90, :margin_top => 60 do
      background gray(0.9), :curve => 5
      image "bird.png", :margin => 5
      @user = edit_line :width => 120
      inscription "Username"
      @pass = edit_line :width => 120, :secret => true
      inscription "Password"
      button "Sign In" do
        @login.remove
        setup_timeline
      end
    end
  end

  def setup_timeline
    @twitter = Twitter::Base.new(@user.text, @pass.text)
    @twitter.verify_credentials
    @timeline = timeline
    new_tweet
    every 60 do
      update_timeline
    end
  rescue Twitter::CantConnect => e
    @login = login
    alert(e)
  end

  def new_tweet
    stack :height => 100, :margin => 5, :top => 400, :align => "right" do
      inscription "What are you doing?", :margin => 0, :margin_bottom => 5, :stroke => gray(0.8)
      @message = edit_box :width => 300, :height => 50
      flow do
        @counter = para "140 characters remaining", :margin_top => 6, :align => "right", :stroke => gray(0.2)
        button( "Post", :left => 0 ) {
          @twitter.post(@message.text, :source => "Chick")
          update_timeline
        }
      end
      @message.change do |message|
        remaining = 140 - message.text.size
        # truncate the text
        message.text = message.text[0...139] if remaining <= 0
        @counter.text = "#{remaining} characters remaining"
      end
    end
  end

  def update_timeline
    @timeline.clear do
      timeline
    end
  end

  def timeline
    stack :height => 400, :scroll => true, :top => 0 do
      @twitter.timeline.each do |status|
        flow :margin_left => 5, :margin_top => 5, :margin_right => 5+gutter do
          background gray(0.9), :curve => 5
          stack :width => 48 + 5 do
            image status.user.profile_image_url, :margin => 5,
                  :click => "http://twitter.com/#{status.user.screen_name}"
          end
          stack :width => -48 - 10 do
            para link(status.user.name, :click => status.user.url, :weight => "bold"),
                 "\n", status.text
            para time_ago(Time.parse(status.created_at)), :margin_top => 0, :align => "right", :size => 8
          end
        end
      end
    end
  end

  def time_ago(time)
    minutes = (Time.now.to_i - time.to_i).floor / 60
    case
      when minutes <= 1
        "less than a minute ago"
      when minutes < 50
        "#{minutes} minutes ago"
      when minutes < 90
        "about an hour ago"
      when minutes < 1080
        "#{(minutes / 60).round} hours ago"
      when minutes < 1440
        "a day ago"
      when minutes < 2880
        "about a day ago"
      else
        "#{(minutes / 1440).round} days ago"
    end
  end

  @login = login
end