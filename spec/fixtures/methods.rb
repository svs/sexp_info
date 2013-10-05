def no_args
  "no args"
end


def one_arg_no_parens foo
  foo
end

def one_arg_parens(foo)
  foo
end

def two_args(foo, bar)
  foo || bar
end

def optional_args(foo, bar = 123)
  bar - 12
end
