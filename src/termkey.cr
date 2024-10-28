require "./lib_termkey"

class Termkey
  @t : LibTermkey::TermKey
  @key = LibTermkey::Key.new
  @key_ptr : Pointer(LibTermkey::Key)
  @format : LibTermkey::Format = LibTermkey::Format::Lowerspace | LibTermkey::Format::Lowermod | LibTermkey::Format::Longmod
  @slice = Bytes.new size: 50
  getter key

  # you'll probably want to set STDIN to raw mode before calling this function
  def initialize(io : IO, flags : LibTermkey::Flags? = nil)
    @t = LibTermkey.new io.fd, (flags ? flags : LibTermkey::Flags::None)
    @key_ptr = pointerof(@key)
  end

  # Used when you're reading STDIN or another FD in crystal.
  # Pass in ENV["TERM"] and use << to feed the key reader.
  def initialize(terminal : String, flags : LibTermkey::Flags? = nil)
    @t = LibTermkey.new_abstract terminal, (flags ? flags : LibTermkey::Flags::None)
    @key_ptr = pointerof(@key)
  end # def

  def finalize
    LibTermkey.destroy @t
  end

  def <<(c : UInt8)
    LibTermkey.push_bytes @t, pointerof(c), 1
  end

  def getkey
    LibTermkey.getkey @t, @key_ptr
  end

  def waitkey
    LibTermkey.waitkey @t, @key_ptr
  end

  def strfkey
    sz = LibTermkey.strfkey(@t, @slice, @slice.size, @key_ptr, @format)
    ret = String.new @slice[0...sz].dup
    @slice.fill 0_u8
    ret
  end
end # class
