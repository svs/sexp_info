module SexpThing

  class Base
    def initialize(sexp)
      @sexp = sexp
    end

    def ==(other)
      other.is_a?(String) ? name == other : self.sexp == other.sexp
    end

    attr_reader :sexp

  end

end

['args','arg','class','module','def'].each do |m|
  require_relative m
end
