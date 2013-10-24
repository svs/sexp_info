require 'sexp_info/sexp_thing/sexp_thing'
class SexpInfo

  VERSION = "0.0.3"

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
