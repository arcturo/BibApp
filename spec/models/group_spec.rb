require File.dirname(__FILE__) + '/../spec_helper'
require 'set'

describe Group do

  describe 'url canonicalization' do
    before(:each) do
      @group = Factory.build(:group)
    end

    it "returns an unchanged url for an http or https uri" do
      @group.url = 'http://example.com'
      @group.canonicalize_url.should == @group.url
      @group.url = 'https://example.com'
      @group.canonicalize_url.should == @group.url
    end

    it 'returns an http:// url for a uri without scheme' do
      @group.url = 'www.example.com'
      @group.canonicalize_url.should == 'http://www.example.com'
    end

    it 'returns # if it is not a valid URI' do
      @group.url = 'lkdasj897(*^*&^&^%jkklsdaj'
      @group.canonicalize_url.should == "#"
    end
  end

  describe 'knows about its group hierarchy' do
    before(:each) do
      @group = Group.create( :name => 'group')
      @son = @group.children.create(:name => 'son')
      @daughter = @group.children.create(:name => 'daughter')
      @grandson = @daughter.children.create(:name => 'grandson')
      @granddaughter = @daughter.children.create(:name => 'granddaughter')
      @dog = @son.children.create(:name => 'dog')
    end

    it "can return top level parent" do
      [@group, @son, @dog].each {|group| group.top_level_parent.should == @group}
    end

    it "can return descendants" do
      @group.descendants.to_set.should == [@son, @daughter, @grandson, @granddaughter, @dog].to_set
      @daughter.descendants.to_set.should == [@grandson, @granddaughter].to_set
      @dog.descendants.should be_empty
    end

    it "can return ancestors and descendants" do
      @group.ancestors_and_descendants.to_set.should == [@son, @daughter, @grandson, @granddaughter, @dog].to_set
      @son.ancestors_and_descendants.to_set.should == [@group, @dog].to_set
      @granddaughter.ancestors_and_descendants.to_set.should == [@group, @daughter].to_set
    end

  end
end
