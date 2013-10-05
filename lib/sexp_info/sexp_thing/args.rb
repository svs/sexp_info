module SexpThing

  class Args < Base

    def [](index)
      args[index]
    end

    def count
      args.count
    end

    private

    def args
      arg_list + optional_args_list
    end

    def arg_list
      return (sexp[1] ? [Arg.new(sexp[1])] : []) if sexp[0] == :params
      (sexp[0] == :paren ? sexp[1][1] : sexp[1]).map{|a| Arg.new(a) }
    end

    def optional_args_list
      as = (sexp[0] == :paren ? sexp[1][2] : sexp[2])
      as ? as.map{|a| Arg.new(a) } : []
    end

  end

end
