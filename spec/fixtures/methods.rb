def no_args
  "no args"
end

def one_arg(foo)
  foo
end

def two_args(foo, bar)
  foo || bar
end

def optional_args(foo, bar = 123)
  bar - 12
end