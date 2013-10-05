require 'spec_helper'
require 'awesome_print'
describe SexpInfo do
  Given(:methods) { File.read('spec/fixtures/methods.rb') }
  Given(:rip) { Ripper.sexp(methods) }
  Given(:sexp) { SexpInfo.new(rip) }
  Then { sexp.defined_methods.should == ["no_args", "one_arg_no_parens", "one_arg_parens" ,"two_args", "optional_args"] }
  Then { sexp["no_args"].arity.should == 0 }
  Then { sexp["one_arg_no_parens"].arity.should == 1 }
  Then { sexp["one_arg_parens"].arity.should == 1 }
  Then { sexp["two_args"].arity.should == 2 }
  Then { sexp["two_args"].args[0].should_not be_optional }
  Then { sexp["optional_args"].args[1].should be_optional }
end
