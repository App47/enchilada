require 'bundler/setup'
require 'test/unit'
require 'roo'
require "shoulda/context"
require File.expand_path(File.dirname(__FILE__) + '/../whole_enchilada')

class WholeEnchiladaParsingTest < Test::Unit::TestCase

  context "WholeEnchilada should be able to parse Excel files following a specific format" do
    setup do
      @enchilada = WholeEnchilada.new("./etc/users.xls")
    end
    
    should "return a collection of 3 user objects" do
      assert_equal 3, @enchilada.users.size
    end
    
    should "return a collection of 3 user objects, all with valid properties" do
      @enchilada.users.each do | usr |
        assert_not_nil usr.name, "name was null?"
        assert_not_nil usr.email, "email address was null?"
        assert_not_nil usr.auto_approve, "auto_approve was null?"
      end
    end
    
  end
end