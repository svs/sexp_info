require "sexp_info/version"
require 'pry_debug'
require 'active_support/all'
class SexpInfo

  def initialize(sexp)
    @sexp = sexp
  end

  def type
    sexp[1][0][0]
  end

  def defined_methods
    instance.defined_methods
  end


  def [](name)
    defined_methods.find{|m| m == name }
  end

  private

  attr_reader :sexp
  def instance
    "SexpInfo::#{type.to_s.camelize}Sexp".constantize.new(sexp)
  end

  def _methods
    sexp[1].select{|x| x[0] == :def}.map{|x| Method.new(x) }
  end

  class SexpThing
    def initialize(sexp)
      @sexp = sexp
    end

    def ==(other)
      other.is_a?(String) ? name == other : self.sexp == other.sexp
    end

    attr_reader :sexp

  end

  class DefSexp < SexpThing

    # This is what we get if we just slam some methods into a file

    def defined_methods
      sexp[1].select{|x| x[0] == :def}.map{|x| Method.new(x) }
    end

  end

  class ClassSexp < SexpThing

    # This works with files that start with `class Foo` etc.

    def defined_methods
      DefSexp.new(sexp[1][0][3]).defined_methods
    end
  end

  class Method < SexpThing

    def name
      sexp[1][1]
    end

    def arity
      args.count
    end

    def args
      Args.new(sexp[2])
    end

  end

  class Args < SexpThing

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

  class Arg < SexpThing
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
