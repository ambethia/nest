require 'tk'
require 'tkextlib/tile'

class Chick
  def initialize
    root = TkRoot.new {
      title "Chick"
      resizable false, false
    }

    content = Tk::Tile::Frame.new(root) {padding 5}.grid(:sticky => "nsew")
    TkGrid.columnconfigure root, 0, :weight => 1
    TkGrid.rowconfigure    root, 0, :weight => 1

    $username = TkVariable.new
    $password = TkVariable.new

    username_field = Tk::Tile::Entry.new(content) {
      textvariable $username
    }.grid( :column => 1, :row => 2, :sticky => "we" )

    password_field = Tk::Tile::Entry.new(content) {
      textvariable $password
      show "*"
    }.grid( :column => 1, :row => 4, :sticky => "we" )

    Tk::Tile::Button.new(content) {
      text "Sign In"
      command { Chick.login }
    }.grid( :column => 1, :row => 6, :sticky => "we")

    Tk::Tile::Label.new(content) { text "Username" }.grid( :column => 1, :row => 3, :sticky => "we", :pady => [0, 12] )
    Tk::Tile::Label.new(content) { text "Password" }.grid( :column => 1, :row => 5, :sticky => "we", :pady => [0, 12])
    Tk::Tile::Label.new(content) {
      image(TkPhotoImage.new(:file => "bird.gif")); anchor "center"
    }.grid( :column => 1, :row => 1, :sticky => "we", :pady => [0, 12] )

    username_field.focus
    root.bind("Return") { Chick.login }
  end

  def self.login
  end

end

Chick.new
Tk.mainloop