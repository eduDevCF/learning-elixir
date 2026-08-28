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

### The Interactive Shell `iex`
Elixir interactive shell in your terminal: `iex`
Exit `iex`: `CTRL+C` then type a(bort)
Interrupt a multi-line input: `#iex:break`

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
[1, 2, 3] ++ [4, 5, 6]
#removing items
[1, true, 2, false, 3, true] -- [true, false]
```
Lists are enumerable and can use the Enum module to perform iterative functions such as mapping.

#### Lists are implemented as singly linked lists.

Lists are not stored in contiguous memory like arrays. They are **singly linked lists**. The first item is stored in a node with the data and a link to the next node (not usually contiguous). The last item links to a terminator. 

To find the length, you must traverse the linked list. The cost varies with the length of the list, but should run in linear time (O(n)). An array always knows it's size, so that can be calculated at a constant rate. However, adding an element to an array takes more work than adding to a linked list which can link to a new node anywhere in memory.

Ultimately, adding to a list or linking to a new node is cheap when your prepend it to the known HEAD node, but the cost comes in traversing the nodes to find the TAIL when you append.

**Prepend to a list**
```
iex> counts = [5, 8, 6]
[5, 8, 6]
iex> updated_counts = [3 | counts]
[3, 5, 8, 6]
```
These are different lists, but they share the items in memory. The items are immutable.

**Append to a list**
Appending an integer to a list using list concatenation creates an improper list.
```
iex> counts ++ 3
[5, 8, 6 | 3]
```

Built-in functions to get the HEAD and the TAIL of a list
```
iex> hd [3.14, :pie, "Apple"]
3.14
iex> tl [3.14, :pie, "Apple"]
[:pie, "Apple"]
```


### Tuples
Tuples are not Enumerable. You can reference tuple values by index but you cannot iterate over them. If you must treat your tuple as a list, then convert it using `Tuple.to_list(your_tuple)`.

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
Reading large tuples is fast while updating them is slow. Reading a large list is slow, but updating it is fast. The kernel modules has a funtion `put_elem(tuple, index, value)` that modifies an item in a tuple and returns a new tuple.

Like arrays in other languages, tuples are a container for data of fixed size in contiguous memory. They are often small with 2-4 elements. Tagged tuple have 2 elements where the first is an atom, often used in success or error responses.

### Keyword Lists
Lists of key, value tuples where keys must be atoms
```
[{:height, 50}, {:width, 10}]
```
Use case: Passing in optional parameters into functions
```
IO.inspect(elem, [{:label, value}, {:width}, value])
```
Short-hand form
```
IO.inspect(elem, [label: value, width: value])
# You can even drop the square brackets around the list when the last parameter is a keyword list
IO.inspect(elem, label: value, width: value)
```

### Maps
- A key-value store
- Unlike keyword lists they are unordered and allow keys of any type
- Define a map with `%{}` syntax
- Access values with square brackets or `Map.get(map_name, key)`

```
iex> map = %{:foo => "bar", "hello" => :world}
%{:foo => "bar", "hello" => :world}
iex> key = "hello"
"hello"
iex> %{key => "world"}
%{"hello" => "world"}

iex> map[:foo]
"bar"
iex> map["hello"]
:world
iex> Map.get(map, :foo)
"bar"
```

The syntax for setting and getting values is different if all keys are atoms:
```
iex> %{foo: "bar", hello: "world"}
%{foo: "bar", hello: "world"}
iex> %{foo: "bar", hello: "world"} == %{:foo => "bar", :hello => "world"}
true

iex> map = %{foo: "bar", hello: "world"}
%{foo: "bar", hello: "world"}
iex> map.hello
"world"
```

Updating a map creates a new map.
```
iex> %{map | foo: "baz"}
%{foo: "baz", hello: "world"}
```

Add a new key to a map with `Map.put/3`
```
# Use `Map.put/3` to add our new key and value
iex> map = Map.put(map, :foo, "baz")
%{foo: "baz", hello: "world"}

# Use `Map.put/3` to update our key
iex> Map.put(map, :foo, "bar")
%{foo: "bar", hello: "world"}
```


### Structs
Map-like data structure
1. Create a module to contain the struct, passing in a list of items or a keyword list with defaults.
```
defmodule Candidate do
  defstruct [:name, :age, :party]
  #defstruct name: "", age: 0, party: :none
end
```
2. Create a variable and bind it to a new struct type.
```
candidate = %Candidate{ name: "Will Ferrel", age: 52, party: :democrat}
```
You can leave out fields, and they will be set to `nil`. But you can't pass in fields that aren't defined in the struct module.

Structs use Map as a Reference module, but there are some things structs can't do that maps can out of the box.

### Variables
- Using the match `=` operator, we can bind a value of any type to a variable name and re-bind any type to a variable.
- No keywords needed to declare a variable.
- starts with lowercase letter 
- all lowercase letters is convention, words separated by an underscore (snake case)
- starting a variable name with a leading underscore means there is no intention of using the variable
- You can technically rebind variables to new data because the old data isn't actually mutated.
- Dynamic typing is determined at runtime while Static typing is determined when compiled. Elixir is compiled but dynamically typed and strongly typed.


## Functions and Modules
- Functions are first class citizens. Functions can take other functions as arguments.
- A function has a name and its arity (the number of arguments it takes).

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

### Named Functions
- must be defined in a module
- `def` keyword defines a public named function
- `defp` defines a private function which can only be used within that module.
- can have 0+ args
- A function always *implicitly returns* the value of the last expression. No need of a return keyword.
- Invoke a function with its `Module.function_name` and passing args

```
defmodule Calculator do
  def subtract(x, y) do
    private_subtract(x, y)
  end

  defp private_subtract(x, y), do: x - y
end

difference = Calculator.subtract(7, 2)
# => 5

difference = Calculator.private_subtract(7, 2)
# => ** (UndefinedFunctionError) function Calculator.private_subtract/2 is undefined or private
#       Calculator.private_subtract(7, 2)
```


### Modules
- A way to group related things (fuctions) and act as a container for defining structs.
- All named functions must be defined in a module.
- Analogous to a class in other languages
- Names should use `PascalCase` and must start with an uppercase letter

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

## Infix functions
Operators like `++` used for concatentation are actually functions. Unlike typical prefix functions where the function name precedes its arguments, the name of prefix functions appears between the args. Example: `arg ++ arg` They are accessible through the Kernel module.

## Macros
- Code that transforms other code
- Like functions take data as parameters, macros take code as parameters.




