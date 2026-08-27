# Learning Elixir
After reading a job posting at Discord for a software engineer on their Notifications team, I noticed they listed Elixir in their tech stack, so I wanted to learn more about it. It fascinated me how it was build on Erlang which was developed by telecoms to support high concurrency on a switchboard. I saw how the Phoenix framework can be used to build efficient, scalable, real-time webapps with web sockets built in, and web sockets vs. polling was something I experimented with during my Hackbright bootcamp for my final project which needed to update a teacher's assignment dashboard UI as students submitted their work without refreshing the page.

So after watching a few YouTube intro videos, I started watching the videos in James Moore's free course [Elixir and Phoenix for Beginners](https://knowthen.com/category/elixir-and-phoenix-for-beginners). I just finished the video on [maps](https://knowthen.com/elixir-and-phoenix-for-beginners/data-types/maps) and realized that his course didn't come with any of source files or exercises. So now I'm also following [dwyl](https://github.com/dwyl)'s [learning-elixir](https://github.com/dwyl/learn-elixir) repo. 

And now I'm swithing to Elixir School's [Basics](https://elixirschool.com/en/lessons/basics/basics?pickup=true#trying-interactive-mode-2) lesson.


## Installing Elixir on Ubuntu(WSL)
Directions from [elixer-lang.org](https://elixir-lang.org/install/#install-scripts)

```
curl -fsSO https://elixir-lang.org/install.sh
sh install.sh elixir@1.20.3 otp@28.4
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.4/bin:$PATH
export PATH=$installs_dir/elixir/1.20.3-otp-28/bin:$PATH
iex
```

Oh glob, I forgot to deactivate the venv for my last Python project. Did I just install elixir there? Will is still work after I deactivate the env? Lemme see. 

This is the print out after running the instal script:
```
(asteroids) stina@RubyBlue:~/dev/alchemy$ sh install.sh elixir@1.20.3 otp@28.4
downloading https://github.com/elixir-lang/elixir/releases/download/v1.20.3/elixir-otp-28.zip
downloading https://builds.hex.pm/builds/otp/amd64/ubuntu-24.04/OTP-28.4.tar.gz
unpacking elixir-otp-28.zip to /home/stina/.elixir-install/installs/elixir/1.20.3-otp-28...
unpacking OTP-28.4.tar.gz to /home/stina/.elixir-install/installs/otp/28.4...
checking OTP... 28 ok
checking Elixir... 1.20.3 ok

Run this (or add to your ~/.bashrc or similar file):

    export PATH=$HOME/.elixir-install/installs/otp/28.4/bin:$PATH
    export PATH=$HOME/.elixir-install/installs/elixir/1.20.3-otp-28/bin:$PATH
```

OK, it looks like everything is fine when I deactivated the venv. It all installed where it was supposed to and all the files were there.

✅ Exported path vars
✅ Additionally, I removed the install.sh file from my directory.

Now I'm following the guide from dwyll's [learn-elixir](https://github.com/dwyl/learn-elixir) repo. But I did not follow their `apt-get` install process.

###Check Everything Installed Correctly 👌
```
elixir -v
Erlang/OTP 28 [erts-16.3] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit:ns]

Elixir 1.20.3 (compiled with Erlang/OTP 28)
```

## Getting Started

Elixir interactive shell in your terminal: `iex`
Exit `iex`: `CTRL+C` then type a(bort)

### Integers
Dividing integers:
"When using the `/` with two integers this gives a `float` (5.0). If you want to do integer division or get the division remainder you can use the `div` or `rem` functions."
```
iex> 10 / 2
5.0
iex> div(10, 2)
5
iex> div 10, 2
5
iex> rem 10, 3
1
```

### Booleans
```
iex> true
true
iex> false
false

iex> is_boolean(true)
true
iex> is_boolean(0)
false
```

Besides the booleans `true` and `false` **`Elixir`** also has the
concept of a "truthy" or "falsy" value.

- a value is truthy when it is neither `false` nor `nil`
- a value is falsy when it is `false` or `nil`

Elixir provides the `||`, `&&`, and `!` boolean operators. These support any types and evaluate "truthiness."

For `and`, `or`, and `not`, the first argument _must_ be a boolean because they are strictly evaluated.

#### Comparison
Comparison operators: `==`, `!=`, `===`, `!==`, `<=`, `>=`, `<`, and `>`.

For strict comparison of integers and floats, use `===`.

Since any two types can be compared in Elixir, types can be sorted according to this hierarchy:
`number < atom < reference < function < port < pid < tuple < map < list < bitstring`


### Atoms
An atom is a constant whose name is its value.
- `:hello`
- `true` and `false`
- `MyApp.MyModule` - Names of modules (even not yet declared ones) are valid atoms.
- `:crypto.strong_rand_bytes 3` - built-in modules
- `:ok` and `:error`

### Strings
You can print a string using the `IO` module
```
iex> IO.puts "Hello world"
"Hello world"
:ok
```

**Interpolation** - `#{var}`
```
iex> name = "Sean"
"Sean"
iex> "Hello #{name}"
"Hello Sean"
```

**Conatenation** - `<>`
```
iex> "Hello " <> name
"Hello Sean"
```

## Collections

### Lists
```
myList = [1,2,3]
length(myList)
#concatentation
[1, 2, 3] ++ [4, 5 ,6 ]
#removing items
[1, true, 2, false, 3, true] -- [true, false]
```
Lists are enumerable and can use the Enum module to perform iterative functions such as mapping.

### Tuples
Tuples are not enumerable. You can reference tuple values by index but you cannot iterate over them. If you must treat your tuple as a list, then convert it using `Tuple.to_list(your_tuple)`.

```
iex> tuple = {:ok, "hello"}
{:ok, "hello"}

# get element at index 1
iex> elem(tuple, 1)
"hello"

# get the size of the tuple
iex> tuple_size(tuple)
2
```
Reading large tuples is fast while updating them is slow. Reading a large list is slow, but updating it is fast.

## Functions and Modules
Functions are first class citizens. Functions can take other functions as arguments.

### Anonymous functions
Anonymous functions are closures (named functions are not) and as such they can access variables that are in scope when the function is defined. 
```
iex> add = fn a, b -> a + b end

#Note the dot between the fn name and args
iex> add.(1, 2)
3

iex> double = fn a -> add.(a, a) end

iex> double.(5)
10
```

### Modules
In order to create your own modules in Elixir, use the `defmodule` macro, then use the `def` macro to define functions in that module. So in this case the module is `Math` and the function is `sum`.
```
defmodule Math do
  def sum(a, b) do
    a + b
  end
end
```
Save a file with the `.ex` extension and run in the terminal:
```
$ elixirc math.ex
```
This will generate a file named `Elixir.Math.beam` containing the bytecode for the defined module. If we start `iex` again, our module definition will be available (provided that iex is started in the same directory the bytecode file is in):
```
iex> Math.sum(1, 2)
3
```



