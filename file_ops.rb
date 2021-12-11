require 'csv'

=begin
This program takes input from a CSV file on student data(name and scores), 
then creates a student object using this details while also calculating the 
average and setting the grade. The output of the object is then presented to the user.
=end

#Class declaration
class Student 
	#attributes
	attr_accessor :student_name, :scores, :average, :grade

	#initialize/new method
	def initialize( student_name = "" )
		@student_name = student_name
		@scores = Array.new(5)
	end
	
	#method to calculate the average based on the student's scores
	def assign_average
		total = 0
		@scores.length.times{|t|
			total = @scores[t] + total
		}
		@average = total / @scores.length
	end

	#set the scores
	def set_scores(scores)
		@scores = scores
	end

	#method to assign the score based on the average score
	def assign_grade
		grade = @average / 10
		if grade == 10 or grade == 9
			@grade = "A"
		elsif grade == 8
			@grade = "B"
		elsif grade == 7
			@grade = "C"
		elsif grade == 6
			@grade = "D"
		else 
			@grade = "E"
		end
	end
end

#array to hold student objects
students = []
#read data from csv file row by row
CSV.foreach("scores.csv") do |row|
	#initialize new student object with the student name
	student = Student.new(row[0])
	#array to store scores
	scores_array = []
	#scores in position 1 to 5, loop through each column
	for i in 1..5
		#store score in i - 1 in array e.g at step 1 column 1 data will be stored in index 0
		scores_array[i - 1] = row[i].to_i
	end
	#set scores
	student.set_scores(scores_array)
	#calculate the average
	student.assign_average
	#calculate the grade
	student.assign_grade
	#push the student object to the last index of the student objects array
	students << student
end
#print the headers
puts "Student Name".ljust(35) + "Scores".ljust(20) + "Average".ljust(10) + "Grade"
#loop through each student in the student objects array
students.length.times { |i|
	#pretty print the student details
	print students[i].student_name.ljust(35)
	print students[i].scores.join(",").ljust(20)
	print students[i].average.to_s.ljust(10)
	print students[i].grade
	print "\n"
}