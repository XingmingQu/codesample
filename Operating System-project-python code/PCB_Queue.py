'''
Part 1: Implementing data structures of the Double linked list and Queue manipulation
This model implement the Double_linked_list and use it to implement PCB_Queue
Some utility Queue manipulation functions are implemented 
'''
from PCB import *

class D_node(object):
	"""The Node of the double linked list"""
	# Initialize a Node: the node have a pre pointer and a next pointer
	def __init__(self, data):  
		self.data = data  # data stores PCB() instance
		self.pre = None
		self.next = None

# After creat the node we can use it to implement PCB_Queue

class PCB_Queue(object):
	"""PCB_Queue class"""
	# Initialize a PCB_Queue: a queue that have a tail node and a head node
	# The Queue should also have a array to store the pids
	def __init__(self):
		self.head = D_node(None)
		self.tail = D_node(None)
		# creat pid array to store pids
		self.pid_array=[]

	# PCB_Queue Functions：

	#1 return queue length
	def get_queue_length(self):
		return len(self.pid_array)

	#2 find function: given a pid and return this process
	def find_node_by_pid(self,pid):
		# First judge if the pid in pid_array
		# If not
		if pid not in self.pid_array:
			raise Exception('The process you want is not in the queue!!')
		# If so
		iterator=self.head
		# Traverse the list to find
		while iterator:
			# iterator.data: get node -> PCB()|| iterator.data.pid: get pid in PCB() 
			if iterator.data.pid == pid:
				return iterator
			iterator = iterator.next
		return None

	#2.1 find function: given a pid and return this process‘s position
	def find_node_position_by_pid(self,pid):
		# First judge if the pid in pid_array
		# If not
		position = 1
		if pid not in self.pid_array:
			raise Exception('The process you want is not in the queue!!')
		# If so
		iterator=self.head
		# Traverse the list to find
		while iterator:
			# iterator.data: get node -> PCB()|| iterator.data.pid: get pid in PCB() 
			if iterator.data.pid == pid:
				return position
			iterator = iterator.next
			position+=1
		return -1

	#3 find function2: given a position and return this process
	def find_node_by_position(self,position):
		# first judge if the position > queue length
		queue_length=self.get_queue_length()
		if position > queue_length:
			raise Exception('Index exceeds the length of the queue !!!')
		# Traverse the list to find
		iterator = self.head
		for i in range(position-1):
			iterator = iterator.next
			# print(iterator.data.pid)
		return iterator

	# get the queue info and return a list
	def get_queue_info(self):
		data=[]
		if self.head.data == self.tail.data == None:
			print('The queue is Empty!')
			return None
		iterator = self.head
		while iterator:
			info=iterator.data.get_PCB_info()
			data.append(info)
			iterator = iterator.next
		return data

	# print the queue in order
	def print_queue_info(self):
		print('\n\n-------------------------------------------------------------------------------------------------------',end='')
		print('\nThere are %d process in the queue\n' % self.get_queue_length() )
		if self.head.data == self.tail.data == None:
			print('The queue is Empty!')
			return

		iterator = self.head
		while iterator:
			iterator.data.print_PCB_info()
			iterator = iterator.next
			# print(iterator)

	# print the queue inverted order 
	def DE_print_queue_info(self):
		print('\nThere are %d process in the queue\n' % self.get_queue_length() )
		if self.head.data == self.tail.data == None:
			print('The queue is Empty!')
			return

		iterator = self.tail
		while iterator:
			iterator.data.print_PCB_info()
			iterator = iterator.pre	

	# Given a pid and print this process's info
	def print_PCB_info_by_pid(self,pid):
		target=self.find_node_by_pid(pid)
		print('\nThe infomation of Process',pid, 'are as follows:')
		target.data.print_PCB_info()



	# Adding a PCB to a given position in the queue
	# The default position is the end (tail) of the queue.
	def add_node(self,PCB,position=None):
		# First judge if the pid alreadly exist
		if PCB.pid in self.pid_array:
			raise Exception('PID Already Exist!')

		# Second jugde if the queue is empty and user want to add in the end
		# using default: add in the end
		if self.get_queue_length() == 0 and position == None:
			# print('add empty')
			self.head.data = PCB
			self.tail.data = PCB

		# if queue only have one node
		elif self.get_queue_length()==1:
			# print('only one')
			new_node = D_node(PCB)
			new_node.pre = self.head
			self.head.next = new_node
			self.tail=new_node
		
		# else if queue is not empty and using given position
		elif position == None or position==self.get_queue_length() :
			# print('add at end')
			new_node = D_node(PCB)
			new_node.pre = self.tail
			self.tail.next = new_node
			self.tail = new_node

		# insert at beginning	
		elif position == 0 :
			new_node = D_node(PCB)
			new_node.next=self.head
			self.head.pre=new_node
			self.head=new_node

		# else user want to insert in a given position
		else:
			# print('add target')
			target=self.find_node_by_position(position)
			# print(target.data.pid)
			new_node=D_node(PCB)
			new_node.next=target.next
			new_node.pre=target
			target.next.pre=new_node
			target.next=new_node
			

		self.pid_array.append(PCB.pid)

	# delete a PCB by given pid
	def delete_node(self,pid=None):
		# First handle default condition--default is deleting the beginning node

		# if queue is empty
		if self.get_queue_length()==0:
			print('The queue is Empty. Can not delete node')
			return
		# default condition
		if pid==None:
			if self.get_queue_length()==1:
				self.head = D_node(None)
				self.tail = D_node(None)
				self.pid_array=[]
				return
			else:
				pointer=self.head
				self.head=pointer.next
				self.head.pre=None
				self.pid_array=self.pid_array[1:]
				del pointer
				return

		# find the target
		target=self.find_node_by_pid(pid)
		# print(target.data.pid)
		position=self.find_node_position_by_pid(pid)
		# print(position)

		# node in the middle
		if 1 < position < self.get_queue_length():
			target.next.pre = target.pre
			target.pre.next = target.next
		# only one node	
		elif self.get_queue_length()==1:
			self.head = D_node(None)
			self.tail = D_node(None)	
		# end of the queue
		elif 1 < position == self.get_queue_length():
			# print('end')
			self.tail=target.pre
			# print(target.pre.data.pid,1111)
			self.tail.next=None
		else:
			target.next.pre=None
			self.head=target.next

		del target
		self.pid_array.remove(pid)




## Test code  ##
# q1=PCB_Queue()
# c=init_by_uesr_input()
# print(c)
# init_by_read_file(q1)

# for i in range(50,55):
# 	p=PCB(i,i,i,i)
# 	q1.add_node(p)


# px=PCB(100,100,100,100)
# q1.add_node(px,3)
# c=q1.find_node_position_by_pid(2)
# q1.delete_node(100)
# print(c)
# px=PCB(1111,100,100,101)
# q1.add_node(px,3)
# px=PCB(22222,100,100,101)
# q1.add_node(px,3)
# print(q1.head.next.data.pid)
# print(q1.pid_array)
# print(q1.get_queue_length())
# q1.print_queue_info()
# q1.DE_print_queue_info()

# q1.print_PCB_info_by_pid(100)
# str = input("Enter your input: ")
# print(str)


			









		






		