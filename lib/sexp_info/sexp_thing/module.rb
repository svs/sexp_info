module SexpThing

  class Module < Base
    def name
      sexp[1][1][1]
    end
    def defined_classes
      SexpInfo.new(sexp[2]).defined_classes
    end
  end

end
