require 'pry_debug'
module SexpThing
  class Def < Base

    def name
      sexp[1][1]
    end

    def arity
      args.count
    end

    def args
      Args.new(sexp[2])
    end

    def line_number
      sexp[1][2][0]
    end

  end
end
