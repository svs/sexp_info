module SexpThing

  class Module < Base
    def name
      sexp[1][1][1]
    end

    def to_h
      Hash[defined_classes.map{|c| [c.name, c.to_h] }].merge(:sexp => self)
    end

    def defined_classes
      SexpInfo.new(sexp[2]).defined_classes
    end
  end

end
