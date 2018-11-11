""" 
Part 1: Implementing data structures and utilities for Process Control Block (PCB)
This model finished init each process info manually by user input or loaded from text
file. And proper Error Handling.

"""
from PCB import *
import pandas as pd

# read and handle exception 
def read_int_from_keyboard_and_check():
	str1 = input()
	# if str1
	flag=True
	while flag:
		try:
			number=int(str1)
			flag=False
		except :
			print('Invalid input! Please input a int number!')
			str1 = input()
	return number


## Init each process info manually by user input
def init_by_uesr_input():

	print('Please input pid')
	pid=read_int_from_keyboard_and_check()

	print('Please input arrival_time')
	arrival_time=read_int_from_keyboard_and_check()

	print('Please input burst_time')
	burst_time=read_int_from_keyboard_and_check()

	print('Please input priority')
	priority=read_int_from_keyboard_and_check()

	print('Please input state--- ready：0,waiting：1,running：2')
	flag=True
	while flag:
		num=read_int_from_keyboard_and_check()
		if num>len(state_list)-1:
			print('Invalid input! Please input state--- ready：0,waiting：1,running：2')
		else:
			state=assign_state(num)
			flag=False

	p=PCB(pid,arrival_time,burst_time,priority,state)

	return p
## added from text file and handle exception 
def init_by_read_file(queue,file_name):
	df = pd.read_csv(file_name,header=0)
	for index, row in df.iterrows():
		pid, arrival_time, burst_time, priority = row
		try:
			pid=int(pid)
			arrival_time=int(arrival_time)
			burst_time=int(burst_time)
			priority=int(priority)

		except :
			raise Exception('Invalid input! Please Check you input File! And make sure your file only has int number!')

		pcb = PCB(pid, arrival_time, burst_time, priority)
		queue.add_node(pcb)