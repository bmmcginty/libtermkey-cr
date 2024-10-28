# libtermkey-cr

Crystal bindings to the libtermkey library.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     libtermkey-cr:
       github: bmmcginty/libtermkey-cr
   ```

2. Run `shards install`

## Usage

```crystal
require "./src/termkey"
STDIN.raw do
tk=Termkey.new STDIN, LibTermkey::Flags::Notermios
res=tk.waitkey
puts "#{res} #{tk.key} #{tk.strfkey}"
tk=nil
end
```

## Development

See src/lib_termkey.cr for available functions.

## Contributing

1. Fork it (<https://github.com/bmmcginty/libtermkey-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Brandon McGinty](https://github.com/bmmcginty) - creator and maintainer
