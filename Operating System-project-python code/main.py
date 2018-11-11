from init_functions import *
from PCB_Queue import *
from scheduler import *




if __name__ == '__main__':

	print("\nThis is CSE 5343/7343, Operating Systems, Fall 2018 Course Project")



	flag=True
	while True :
		print("\nPlease select your scheduler Algorithm")
		print('1--FCFS')
		print('2--non_preemptive')
		print('3--round_robin')
		scheduler=read_int_from_keyboard_and_check()

		print("\nPlease select your data set")
		print('1--Baseline sample Data')
		print('2--Another larger set')
		dataset=read_int_from_keyboard_and_check()

		q1=PCB_Queue()

		if dataset==1:
			init_by_read_file(q1,'processes_data.csv')
		else:
			init_by_read_file(q1,'processes_data_large.csv')

		q1.print_queue_info()

		if scheduler==1:
			FSFC(q1)
		if scheduler==2:
			non_preemptive(q1)
		if scheduler==3:
			round_robin(q1,2)


		print('\nFinish simulation! Do you want to try another scheduler? y/n')
		ans=input()
		if ans=='n':
			break

		# q1.print_queue_info()
		# non_preemptive(q1)
		# round_robin(q1,2)




