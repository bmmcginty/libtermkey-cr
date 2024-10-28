@[Link(ldflags: "-ltermkey")]
lib LibTermkey
  enum Sym
    Unknown   = -1
    None      =  0
    Backspace
    Tab
    Enter
    Escape
    Space
    Del
    Up
    Down
    Left
    Right
    Begin
    Find
    Insert
    Delete
    Select
    Pageup
    Pagedown
    Home
    End
    Cancel
    Clear
    Close
    Command
    Copy
    Exit
    Help
    Mark
    Message
    Move
    Open
    Options
    Print
    Redo
    Reference
    Refresh
    Replace
    Restart
    Resume
    Save
    Suspend
    Undo
    KP_0
    KP_1
    KP_2
    KP_3
    KP_4
    KP_5
    KP_6
    KP_7
    KP_8
    KP_9
    Kpenter
    Kpplus
    Kpminus
    Kpmult
    Kpdiv
    Kpcomma
    Kpperiod
    Kpequals
    N_SYMS
  end

  enum Type
    Unicode
    Function
    Sym
    Mouse
    Position
    Modereport
    Dcs
    Osc
    UnknownCsi = -1
  end

  enum Result
    None
    Key
    Eof
    Again
    Error
  end

  enum MouseEvent
    Unknown
    Press
    Drag
    Release
  end

  enum Keymod
    None  = 0
    Shift = 1 << 0
    Alt   = 1 << 1
    Ctrl  = 1 << 2
  end

  union Anonymous1
    codepoint : LibC::Long
    number : LibC::Int
    sym : Sym
    mouse : LibC::Char[4]
  end

  struct Key
    type : Type
    code : Anonymous1
    modifiers : Keymod
    utf8 : LibC::Char[7]
  end

  type TermKey = Void*

  enum Flags
    None        = 0
    Nointerpret = 1 << 0
    Convertkp   = 1 << 1
    Raw         = 1 << 2
    Utf8        = 1 << 3
    Notermios   = 1 << 4
    Spacesymbol = 1 << 5
    Ctrlc       = 1 << 6
    Eintr       = 1 << 7
    Nostart     = 1 << 8
  end

  enum CanonFlags
    Spacesymbol = 1 << 0
    Delbs       = 1 << 1
  end

  fun check_version = "termkey_check_version"(major : LibC::Int, minor : LibC::Int) : Void

  fun new = "termkey_new"(fd : LibC::Int, flags : Flags) : TermKey

  fun new_abstract = "termkey_new_abstract"(term : LibC::Char*, flags : Flags) : TermKey

  fun free = "termkey_free"(tk : TermKey) : Void

  fun destroy = "termkey_destroy"(tk : TermKey) : Void

  alias TerminfoGetstrHook = (LibC::Char*, LibC::Char*, Void*) -> LibC::Char*

  fun hook_terminfo_getstr = "termkey_hook_terminfo_getstr"(tk : TermKey, hookfn : TerminfoGetstrHook*, data : Void*) : Void

  fun start = "termkey_start"(tk : TermKey) : LibC::Int

  fun stop = "termkey_stop"(tk : TermKey) : LibC::Int

  fun is_started = "termkey_is_started"(tk : TermKey) : LibC::Int

  fun get_fd = "termkey_get_fd"(tk : TermKey) : LibC::Int

  fun get_flags = "termkey_get_flags"(tk : TermKey) : Flags

  fun set_flags = "termkey_set_flags"(tk : TermKey, newflags : Flags) : Void

  fun get_waittime = "termkey_get_waittime"(tk : TermKey) : LibC::Int

  fun set_waittime = "termkey_set_waittime"(tk : TermKey, msec : LibC::Int) : Void

  fun get_canonflags = "termkey_get_canonflags"(tk : TermKey) : CanonFlags

  fun set_canonflags = "termkey_set_canonflags"(tk : TermKey, flags : CanonFlags) : Void

  fun get_buffer_size = "termkey_get_buffer_size"(tk : TermKey) : LibC::SizeT

  fun set_buffer_size = "termkey_set_buffer_size"(tk : TermKey, size : LibC::SizeT) : LibC::Int

  fun get_buffer_remaining = "termkey_get_buffer_remaining"(tk : TermKey) : LibC::SizeT

  fun canonicalise = "termkey_canonicalise"(tk : TermKey, key : Key*) : Void

  fun getkey = "termkey_getkey"(tk : TermKey, key : Key*) : Result

  fun getkey_force = "termkey_getkey_force"(tk : TermKey, key : Key*) : Result

  fun waitkey = "termkey_waitkey"(tk : TermKey, key : Key*) : Result

  fun advisereadable = "termkey_advisereadable"(tk : TermKey) : Result

  fun push_bytes = "termkey_push_bytes"(tk : TermKey, bytes : LibC::Char*, len : LibC::SizeT) : LibC::SizeT

  fun register_keyname = "termkey_register_keyname"(tk : TermKey, sym : Sym, name : LibC::Char*) : Sym

  fun get_keyname = "termkey_get_keyname"(tk : TermKey, sym : Sym) : LibC::Char*

  fun lookup_keyname = "termkey_lookup_keyname"(tk : TermKey, str : LibC::Char*, sym : Sym*) : LibC::Char*

  fun keyname2sym = "termkey_keyname2sym"(tk : TermKey, keyname : LibC::Char*) : Sym

  fun interpret_mouse = "termkey_interpret_mouse"(tk : TermKey, key : Key*, event : MouseEvent*, button : LibC::Int*, line : LibC::Int*, col : LibC::Int*) : Result

  fun interpret_position = "termkey_interpret_position"(tk : TermKey, key : Key*, line : LibC::Int*, col : LibC::Int*) : Result

  fun interpret_modereport = "termkey_interpret_modereport"(tk : TermKey, key : Key*, initial : LibC::Int*, mode : LibC::Int*, value : LibC::Int*) : Result

  fun interpret_csi = "termkey_interpret_csi"(tk : TermKey, key : Key*, args : LibC::Long*, nargs : LibC::SizeT*, cmd : LibC::ULong*) : Result

  fun interpret_string = "termkey_interpret_string"(tk : TermKey, key : Key*, strp : LibC::Char**) : Result

  enum Format
    Longmod     = 1 << 0
    Caretctrl   = 1 << 1
    Altismeta   = 1 << 2
    Wrapbracket = 1 << 3
    Spacemod    = 1 << 4
    Lowermod    = 1 << 5
    Lowerspace  = 1 << 6
    MOUSE_POS   = 1 << 8
  end

  Vim = (ALTISMETA | WRAPBRACKET)

  Urwid = (LONGMOD | ALTISMETA | LOWERMOD | SPACEMOD | LOWERSPACE)

  fun strfkey = "termkey_strfkey"(tk : TermKey, buffer : LibC::Char*, len : LibC::SizeT, key : Key*, format : Format) : LibC::SizeT

  fun strpkey = "termkey_strpkey"(tk : TermKey, str : LibC::Char*, key : Key*, format : Format) : LibC::Char*

  fun keycmp = "termkey_keycmp"(tk : TermKey, key1 : Key*, key2 : Key*) : LibC::Int
end
