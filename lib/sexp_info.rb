require 'active_support/all'
require 'sexp_info/sexp_thing/sexp_thing'
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

  def to_h
    Hash[children.map{|c| [c.name, c.to_h] }]
  end

  def defined_modules
    defined(:module)
  end


  def children
    defined_classes + defined_methods + defined_modules
  end

  def [](name)
    (children).find{|m| m == name }
  end

  private

  attr_reader :sexp
  def defined(type)
    sexp[1] ? sexp[1].find_all{|s| s[0] == type}.map{|c| "SexpThing::#{type.to_s.camelize}".constantize.new(c) } : []
  end

end
