require "sexp_info/version"
require 'pry_debug'
class SexpInfo

  def initialize(sexp)
    @sexp = sexp
  end

  def defined_methods
    _methods
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

    def ==(other)
      other.is_a?(String) ? name == other : self.sexp == other.sexp
    end

    attr_reader :sexp
  end
end
