'''
Part 1: Implementing data structures and utilities for Process Control Block (PCB)
Each PCB should have a uniform format.
This model implement the PCB data structures

'''

state_list=['ready','waiting','running']

class PCB(object):
	"""PCB class"""

	# Initialize a process 
	# Default state of the process is set to 'ready'
	def __init__(self, pid, arrival_time, burst_time, priority, state='ready'):
		self.pid = pid    
		self.arrival_time = arrival_time
		self.burst_time = burst_time
		self.remaining_time = self.burst_time   # remaining_time is first set to burst_time
		self.priority = priority   # low numbers represent high priority
		self.state = state

	def __str__(self):
		str= 'pid:%6d   arrival_time:%6d   burst_time:%6d   priority：%6d   state:%10s' \
			%(self.pid, self.arrival_time, self.burst_time, self.priority, self.state )
		return str

	# Print the infomation of the current process
	def print_PCB_info(self):
		print('pid:%6d   arrival_time:%6d   burst_time:%6d   priority：%6d   state:%10s' \
			%(self.pid, self.arrival_time, self.burst_time, self.priority, self.state ))

	# Get the infomation of the current process
	def get_PCB_info(self):
		return [self.pid, self.arrival_time, self.burst_time, self.priority, self.state, self.remaining_time]

def assign_state(state_num):
	return state_list[state_num]





# c=init_by_uesr_input()
# Test code #
# c=assign_state(2)
# c.print_PCB_info()
# c=read_from_keyboard_and_check()
# print(c)
# s=dict(pid=1, arrival_time=2, burst_time=3, priority=4)
# p1=PCB(**s)
# print(p1)
# p1.print_PCB_info()
# a=p1.get_PCB_info()
# print(a[0])
# print(a,b,c,d,e)
# a=''
# print(type(a)==int)