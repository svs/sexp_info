require 'spec_helper'
require 'awesome_print'
describe SexpInfo do
  Given(:methods) { File.read('spec/fixtures/methods.rb') }
  Given(:rip) { Ripper.sexp(methods) }
  Given(:sexp) { SexpInfo.new(rip) }
  Then { sexp.defined_methods.should == ["no_args", "one_arg", "two_args", "optional_args"] }
end
