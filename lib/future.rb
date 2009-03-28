# Future implements the future concept from IO.
# A future is an object that you create now, but which only gets a usable
# value in the future. Think of asynchronous messaging and long-lasting method
# calls.
#
# An example:
#   f = Future.new { sleep 5; 123}
#   puts f * 5 #=> 615
# This future will take 5 seconds to run, then 123 is returned.
# The call f.*(5) will block until the future is done.
#
# Another example:
#   f1 = Future.new { sleep 5; 10}
#   f2 = Future.new { sleep 3; 20}
#   f3 = Future.new { sleep 1; 30}
#   puts f3 + f2 + f1
# Here it only takes 5 seconds to calculate the sum instead of the 9 it would take when done sequentially.
class Future
  (instance_methods - %w[__send__ __id__ object_id]).each do |meth|
    undef_method meth
  end

  def initialize(&block)
    @thread = Thread.new(&block)
  end

  def method_missing(*args, &block)
    @thread.value.send(*args,&block)
  end
end
