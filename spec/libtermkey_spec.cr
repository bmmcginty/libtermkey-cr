require "./spec_helper"

describe Termkey do
tk=nil

it "initializes" do
tk=Termkey.new "vt100"
end

  it "works" do
tk.not_nil! << 'j'.ord.to_u8
res=tk.not_nil!.getkey
tk.not_nil!.strfkey
  end # it
end # done
