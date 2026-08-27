# adapted from excercism.org

defmodule HelloWorld do
  @doc """
  Simply returns the inaugural greeting "Hello World!"
  """
  @spec hello :: String.t()
  def hello do
    "Hello World!"
  end
end

# HOW DO YOU ACTUALLY GET THIS TO RUN IN IEX?
# HelloWorld.hello
