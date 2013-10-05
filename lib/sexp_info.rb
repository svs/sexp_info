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
    defined(:def)
  end

  def defined_classes
    defined(:class)
  end

  def defined_modules
    defined(:module)
  end

  def [](name)
    (defined_classes + defined_methods + defined_modules).find{|m| m == name }
  end

  private

  attr_reader :sexp
  def defined(type)
    sexp[1] ? sexp[1].find_all{|s| s[0] == type}.map{|c| "SexpThing::#{type.to_s.camelize}".constantize.new(c) } : []
  end

end

module SexpThing

  class SexpThing
    def initialize(sexp)
      @sexp = sexp
    end

    def ==(other)
      other.is_a?(String) ? name == other : self.sexp == other.sexp
    end


    attr_reader :sexp

  end

  class Def < SexpThing

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

  class Class < SexpThing

    def name
      sexp[1][1][1]
    end

    def defined_methods
      SexpInfo.new(sexp[3]).defined_methods
    end
  end

  class Module < SexpThing
    def name
      sexp[1][1][1]
    end
    def defined_classes
      SexpInfo.new(sexp[2]).defined_classes
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

    def name
      sexp[1]
    end

    def optional?
      sexp.count == 2
    end

  end
end
