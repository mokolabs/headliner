require File.dirname(__FILE__) + '/spec_helper'

describe "Headliner" do
  
  before(:each) do
    @view = ActionView::Base.new
  end
  
  describe "loading plugin" do
    
    it "should be mixed into ActionView::Base" do
      ActionView::Base.included_modules.include?(Headliner).should be_true
    end
  
    it "should respond to 'title' helper" do
      @view.should respond_to(:title)
    end
    
    it "should respond to 'title' helper alias" do
      @view.should respond_to(:t)
    end
    
  end
  
  describe "saving title" do
    
    it "should save title" do
      @view.title("iPhone").should eql("iPhone")
    end

    it "should save headline if present" do
      @view.title("iPhone", "iPhone 3G is now on sale!").should eql("iPhone 3G is now on sale!")
    end
    
  end
  
  describe "displaying title" do
    
    it "should use website name if title is empty" do
      @view.title(:site => "Apple").should eql("<title>Apple</title>")
    end
    
    it "should use website before page by default" do
      save_basic_title
      @view.title(:site => "Apple").should eql("<title>Apple | iPhone</title>")
    end
    
    it "should only use markup in titles in the view" do
      save_basic_title("<b>iPhone</b>").should eql("<b>iPhone</b>")
      @view.title(:site => "Apple").should eql("<title>Apple | iPhone</title>")
    end
    
    it "should use page before website if :reverse" do
      save_basic_title
      @view.title(:site => "Apple", :reverse => true).should eql("<title>iPhone | Apple</title>")
    end
        
    it "should be lowercase if :lowercase" do
      save_basic_title
      @view.title(:site => "apple", :lowercase => true).should eql("<title>apple | iphone</title>")
    end
    
    it "should use custom separator if :separator" do
      save_basic_title
      @view.title(:site => "Apple", :separator => "-").should eql("<title>Apple - iPhone</title>")
      @view.title(:site => "Apple", :separator => ":").should eql("<title>Apple : iPhone</title>")
      @view.title(:site => "Apple", :separator => "&mdash;").should eql("<title>Apple &mdash; iPhone</title>")
    end
    
    it "should use custom prefix and suffix if available" do
      save_basic_title
      @view.title(:site => "Apple", :prefix => " |", :suffix => "| ").should eql("<title>Apple ||| iPhone</title>")
    end
    
    it "should collapse prefix if false" do
      save_basic_title
      @view.title(:site => "Apple", :prefix => false, :separator => ":").should eql("<title>Apple: iPhone</title>")
    end
    
    it "should collapse suffix if false" do
      save_basic_title
      @view.title(:site => "Apple", :suffix => false, :separator => "~").should eql("<title>Apple ~iPhone</title>")
    end
    
    it "should use all custom options if available" do
      save_basic_title
      @view.title(:site => "apple", 
                  :prefix => " ", 
                  :suffix => " ", 
                  :separator => "-",
                  :lowercase => true,
                  :reverse => true).should eql("<title>iphone - apple</title>")
    end
    
    it "should use default one if title is not present or blank" do
      save_basic_title("")
      @view.title(:site => "Apple", :default => "New MacBook").should eql("<title>Apple | New MacBook</title>")
    end
    
  end
  
  def save_basic_title(title='iPhone')
    @view.title(title)
  end
  
end