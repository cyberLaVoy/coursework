import statistics

class Matrix:
	def __init__(self, matrix):
		self.mMatrix = matrix

	def mean(self):
		list_of_means = []
		for i in range(len(self.mMatrix)):
			list_of_means.append(statistics.mean(self.mMatrix[i]))
		return list_of_means
			
	def scale(self, value):
		for i in range(len(self.mMatrix)):
			for j in range(len(self.mMatrix[i])):
				self.mMatrix[i][j] *= value
		return True

	def transpose(self):
		trans_matrix = []
		for j in range(len(self.mMatrix[0])):
			value_list = []
			for i in range(len(self.mMatrix)):
				value_list.append(self.mMatrix[i][j])
			trans_matrix.append(value_list)
		self.mMatrix = trans_matrix
		return True


	def __add__(self, other):
		new_matrix = []
		for i in range(len(self.mMatrix)):
			value_list = []
			for j in range(len(self.mMatrix[i])):
				a = self.mMatrix[i][j] 
				b = other.mMatrix[i][j] 
				value_list.append(a + b)
			new_matrix.append(value_list)
		return Matrix(new_matrix)

	def __str__(self):
		for i in range(len(self.mMatrix)):
			value_list = []
			for j in range(len(self.mMatrix[i])):
				a = self.mMatrix[i][j] 
				value_list.append(a)
			print(str(value_list))	
		return ""
