describe Stampable do
  class ActiveRecordModel
    attr_accessor :modified_by

    #stub activerecord method
    def self.before_save msg
      @msg = msg
    end

    include Stampable::Base

    def invoke_before_save
      send :set_modified_by
    end

    #stub activerecord method
    def changed?
      true
    end
  end

  before :all do
    Stampable::Base.config = {:default_user => 'user'}
  end

  after :each do
    Thread.current['current_user'] = nil
  end


  it 'should set default current user if not set in thread local' do
    model = ActiveRecordModel.new
    model.invoke_before_save
    model.modified_by.should == 'user'
  end

  it 'should set user from thread local' do
    Thread.current['current_user'] = 'user1'
    model = ActiveRecordModel.new
    model.invoke_before_save

    model.modified_by.should == 'user1'
  end

  it 'should not set user if model is not changed' do
    model = ActiveRecordModel.new
    model.stub(:changed?).and_return(false)
    model.invoke_before_save

    model.modified_by.should == nil
  end

  it 'should not update user if model is not changed' do
    model = ActiveRecordModel.new
    model.modified_by = 'some user'
    model.stub(:changed?).and_return(false)
    model.invoke_before_save

    model.modified_by.should == 'some user'
  end


  it 'should set user to the stamp_field' do
    Stampable::Base.config = {:stamp_field => 'touched_by'}

    class ActiveRecordModel
      attr_accessor :touched_by
    end

    model = ActiveRecordModel.new
    model.invoke_before_save

    model.touched_by.should == 'user'
    model.modified_by.should == nil
  end

  it 'should not update the user if it belongs to except user list' do
    Stampable::Base.config.merge({:except_user_list=>["job"]})

    model = ActiveRecordModel.new
    model.modified_by = 'some user'
    Thread.current['current_user'] = 'job'

    model.invoke_before_save

    model.modified_by.should == 'some user'
  end

end
