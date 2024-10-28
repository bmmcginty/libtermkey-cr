require "../src/termkey"
STDIN.raw do
  t = Termkey.new ENV["TERM"], LibTermkey::Flags::Utf8
  a = 0
  start = Time.monotonic
  while 1
    c = STDIN.read_byte
    break if !c
    c2 = c.not_nil!
    t << c2
    res = t.getkey
    if res.key?
      v = t.strfkey
      puts "#{v} #{t.key.inspect}"
      a += 1
      break if t.key.type.unicode? && t.key.code.codepoint == 'q'.ord && t.key.modifiers.ctrl?
    end # key
  end   # while
  puts "#{a/(Time.monotonic - start).total_seconds} keys per sec"
end
