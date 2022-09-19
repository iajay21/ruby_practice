a = [{python: "mike"}, {java: "garima"}, {rails: "mike"}]

output = {mike: ["python", "rails"], garima: ["java"]}

a = [{"Python": "Mike"}, {"Ruby": "John"}, {"Rails": "Mike"}, {"PHP": "Denial"}, {"Swift": "John"}]

output = {"Mike": ["Python", "Rails"], "John": ["Ruby", "Swift"], "Denial": ["PHP"] }

def convert_hash(a)
	h= {}
	a.each do |a1|
		a1.each do |k, v|
			# h[v] = [k.to_s] unless h[v]
			if h[v].present?
				h[v] << k.to_s
			else
				h[v] = [k.to_s]
			end
		end
	end
	return h
end

-------------------------------------------------------------------
array = [1, 2, 3, 2, 4, 3, 1, 4, 6, 8, 4, 5, 9, 7, 3, 2]
output = [6, 8, 5, 9, 7]
array.group_by(&:itself).reject{|k, v| v.count > 1}.keys

#without using uniq method
b = array & array


output = [1, 2, 3, 4]
array.group_by(&:itself).reject{|k, v| v.count == 1}.keys

-------------------------------------------------------------------
array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

output = [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
c = []
array.each do |a|
	c << (0..a.length - 1).to_a
end
c = c.uniq.flatten
b = []
b = [array.map{|a1| a1[0]}, array.map{|a1| a1[1]}, array.map{|a1| a1[2]}]
c.each do |c1|
	b << array.map{|a1| a1[c1]}
end

--------------------------------------------------------------------------
#fibonacci series in ruby 
def fib(num)
   i, j = 0, 1
   while i <= num
     puts i
     i, j = j, i + j
   end
end

def fib(n)
	array = []
  a, b = 0, 1
  while b < n do
    puts b
    array << b
    a, b = b, a+b
  end
  return array
end
----------------------------------------------------------------------
#find missing numbers from array
a = [1,2,3,5,7]
b = (1..7).to_a
p b-a #=> [4, 6]

-----------------------------------------------
n = 10
input = [3, 6, 8, 2, 1, 9, 5, 7]
temp = Array.new(n+1, 0)
input.each { |item| temp[item] = 1 }
result = []
1.upto(n) { |i| result << i if temp[i] == 0 }
-----------------------------------------------

array = [0, 1, 2, 4, 5, 6, 9, 10, 12, 13, 17]
possible_missing = array.flat_map {|e| [e-1, e+1]}.uniq
#=> [1, 0, 2, 3, 5, 4, 6, 7, 8, 10, 9, 11, 13, 12, 14, 16, 18]
diff = (possible_missing - array).select {|e| e >= 0}
#=> [3, 7, 8, 11, 14, 16, 18]


----------------------------------------------------------------------
# Ruby program for flat_map method in Enumerable
  
enu = [12, 18]
  
res = enu.flat_map { |el| [2*el, 3*el] }
Output = [24, 36, 36, 54]
  
enu = [[17, 21], [19, 100]]
  
res = enu.flat_map { |el| el + [1000] }

output = [17, 21, 1000, 19, 100, 1000]

----------------------------------------------------------------------
def contains_vowel(str)
  str =~ /[aeiou]/
end
contains_vowel("test") # returns 1
contains_vowel("sky")

-----------------------------------------------------------------------
# https://stackoverflow.com/questions/53381034/is-there-a-way-to-be-explicit-on-select-columns-when-using-includes-in-rai
Project.includes(:charity).pluck(:id, :name, 'charities.name')

Project.left_joins(:charity).select(:id, "charities.name")

Project.joins(:charity).select(:id, "charities.name")

Project.includes(:charity).select(:id, :name, 'charities.name')