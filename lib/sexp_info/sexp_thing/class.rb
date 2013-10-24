module SexpThing

  class Class < Base

    def name
      sexp[1][1][1]
    end

    def to_h
      defined_methods.map{|m| [m.name, m]}.merge(:sexp => self)
    end

    def defined_methods
      SexpInfo.new(sexp[3]).defined_methods
    end
  end

end
