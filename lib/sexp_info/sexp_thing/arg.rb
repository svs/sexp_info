module SexpThing

  class Arg < Base

    def name
      sexp[1]
    end

    def optional?
      sexp.count == 2
    end

  end

end
