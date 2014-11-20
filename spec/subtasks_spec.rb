require 'spec_helper'
require 'subtasks'

describe Subtasks do

  let(:db) { double }
  let(:db_table) { double(Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db")) }
  let(:selected) { double }

  describe '#finish!' do
    it 'should change status to finished' do
      allow(db).to receive(:[]).with(:subtasks) { db_table }
      allow(db_table).to receive(:where).with("id = ?", 1) { selected }
      expect(selected).to receive(:update).with(status: 1)
      test = Subtasks.new(db)
      test.finish!(1)
    end
  end
end

# describe Subtasks do
#   let(:subtasks) { [
#       { id: 1, task_id: 1, title: 'Подзадача 1', status: 0, created_at: 1415791040 },
#       { id: 2, task_id: 2, title: 'Подзадача 2', status: 0, created_at: 1415791041 },
#       { id: 3, task_id: 3, title: 'Подзадача 3', status: 0, created_at: 1415791042 },
#       { id: 4, task_id: 4, title: 'Подзадача 4', status: 0, created_at: 1415791043 },
#       { id: 5, task_id: 5, title: 'Подзадача 5', status: 0, created_at: 1415791044 },
#       { id: 6, task_id: 6, title: 'Подзадача 6', status: 0, created_at: 1415791045 },
#       { id: 7, task_id: 7, title: 'Подзадача 7', status: 0, created_at: 1415791046 },
#       { id: 8, task_id: 8, title: 'Подзадача 8', status: 0, created_at: 1415791047 },
#       { id: 9, task_id: 9, title: 'Подзадача 9', status: 0, created_at: 1415791048 },
#       { id: 10, task_id: 1, title: 'Подзадача 10', status: 0, created_at: 1415791049 },
#       { id: 11, task_id: 1, title: 'Подзадача 11', status: 0, created_at: 1415791050 },
#       { id: 12, task_id: 1, title: 'Подзадача 12', status: 0, created_at: 1415791051 },
#       { id: 13, task_id: 1, title: 'Подзадача 13', status: 0, created_at: 141579104052 },
#     ] }

#   describe 'Subtasks#create' do
#     it 'should save subtask to DB' do
#       db = double(Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
#       db_subtasks = double
#       subtasks.each do |subtask|
#         allow(db).to receive(:[]).with(:subtasks) { db_subtasks }
#         expect(db_subtasks).to receive(:insert).with(
#           task_id: subtask[:task_id], title: subtask[:title], status: 0, created_at: subtask[:created_at])
#         test_subtasks = Subtasks.new(db)
#         test_subtasks.create(task_id: subtask[:task_id], title: subtask[:title], status: 0, created_at: subtask[:created_at])
#       end
#     end
#   end
# end