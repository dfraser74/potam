require 'spec_helper'
require 'db'

class Test_DB < DB
end

describe DB do
  
  let(:test_data) { [
    { id: 1, param_int1: 1, param_str1: 'value1', param_int2: 1, param_str2: 'value1' },
    { id: 2, param_int1: 2, param_str1: 'value2', param_int2: 2, param_str2: 'value2' },
    { id: 3, param_int1: 3, param_str1: 'value3', param_int2: 3, param_str2: 'value3' }
    # { id: 4, param_int1: 4, param_str1: 'value4', param_int2: 4, param_str2: 'value4' },
    # { id: 5, param_int1: 5, param_str1: 'value5', param_int2: 5, param_str2: 'value5' },
    # { id: 6, param_int1: 6, param_str1: 'value6', param_int2: 6, param_str2: 'value6' },
    # { id: 7, param_int1: 7, param_str1: 'value7', param_int2: 7, param_str2: 'value7' },
    # { id: 8, param_int1: 8, param_str1: 'value8', param_int2: 8, param_str2: 'value8' },
    # { id: 9, param_int1: 9, param_str1: 'value9', param_int2: 9, param_str2: 'value9' },
    # { id: 10, param_int1: 10, param_str1: 'value10', param_int2: 10, param_str2: 'value10' },
    # { id: 11, param_int1: 11, param_str1: 'value11', param_int2: 11, param_str2: 'value11' },
    # { id: 12, param_int1: 12, param_str1: 'value12', param_int2: 12, param_str2: 'value12' },
    # { id: 13, param_int1: 13, param_str1: 'value13', param_int2: 13, param_str2: 'value13' },
  ] }

  let(:db) { double }

  let(:db_table) { double(Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db")) }

  before(:each) do
    allow(db).to receive(:[]).with(:test_db) { db_table }
  end

  describe '#initialize' do
    it 'should create attr_reader according class name' do
      test = Test_DB.new
      expect(test).to respond_to(:new_test_d_id)
    end
    it 'should connect to table by class name' do
      expect(db).to receive(:[]).with(:test_db)
      test = Test_DB.new(db)
    end
  end

  describe '#create' do
    it 'should save data to table' do
      test_data.each do |record|
        expect(db_table).to receive(:insert).with(record) { record[:id] }
        test = Test_DB.new(db)
        test.create(record)
        expect(test.new_test_d_id).to eq(record[:id])
      end
    end
  end

  describe '#last' do
    it 'should return 10 last records ordered by id desc' do
      ordered = double
      limited = double
      allow(db_table).to receive(:order).with(Sequel.desc(:id)) { ordered }
      allow(ordered).to receive(:limit).with(10) { limited }
      expect(limited).to receive(:all)
      test = Test_DB.new(db)
      test.last
    end
  end

  describe '#list' do
    it 'should return all records ordered by id desc' do
      ordered = double
      allow(db_table).to receive(:order).with(Sequel.desc(:id)) { ordered }
      expect(ordered).to receive(:all)
      test = Test_DB.new(db)
      test.list
    end
  end

  describe '#info' do
    it 'should return record by id' do
      selected = double
      allow(db_table).to receive(:where).with("id = ?", 1) { selected }
      expect(selected).to receive(:first)
      test = Test_DB.new(db)
      test.info(1)
    end
  end

end