require 'spec_helper'
require 'awesome_print'
describe SexpInfo do

  context "methods only" do
    Given(:methods) { File.read('spec/fixtures/methods.rb') }
    Given(:rip) { Ripper.sexp(methods) }
    Given(:sexp) { SexpInfo.new(rip) }
    Then { sexp.type.should == :def }
    Then { sexp.defined_methods.should == ["no_args", "one_arg_no_parens", "one_arg_parens" ,"two_args", "optional_args"] }
    Then { sexp["no_args"].arity.should == 0 }
    Then { sexp["one_arg_no_parens"].arity.should == 1 }
    Then { sexp["one_arg_parens"].arity.should == 1 }
    Then { sexp["two_args"].arity.should == 2 }
    Then { sexp["two_args"].args[0].should_not be_optional }
    Then { sexp["optional_args"].args[1].should be_optional }
  end


  context "classes" do
    Given(:classes) { File.read('spec/fixtures/classes.rb') }
    Given(:rip) { Ripper.sexp(classes) }
    Given(:sexp) { SexpInfo.new(rip) }
    Then { sexp.type.should == :class }
    Then { sexp.defined_methods.should == ["optional_args"] }
    Then { sexp["optional_args"].arity.should == 2 }
  end
end
