require "sexp_info/version"
require 'pry_debug'
class SexpInfo

  def initialize(sexp)
    @sexp = sexp
  end

  def defined_methods
    _methods
  end

  def [](name)
    defined_methods.find{|m| m == name }
  end

  private

  attr_reader :sexp

  def _methods
    sexp[1].select{|x| x[0] == :def}.map{|x| Method.new(x) }
  end


  class Method
    def initialize(sexp)
      @sexp = sexp
    end

    def name
      sexp[1][1]
    end

    def arity
      args.count
    end

    def ==(other)
      other.is_a?(String) ? name == other : self.sexp == other.sexp
    end

    attr_reader :sexp

    def args
      Args.new(sexp[2])
    end

  end

  class Args

    def initialize(sexp)
      @sexp = sexp
    end

    def [](index)
      args[index]
    end

    def count
      args.count
    end

    attr_reader :sexp

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

  class Arg
    def initialize(sexp)
      @sexp = sexp
    end

    def name
      sexp[1]
    end

    def optional?
      sexp.count == 2
    end

    attr_reader :sexp
  end



end
