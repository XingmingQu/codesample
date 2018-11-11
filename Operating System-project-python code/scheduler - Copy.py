'''
Part2 Writing different schedulers
For CSE7343 Students: Implement FCFS Scheduling, Non-preemptive
Priority scheduling (Use only 1,2,3,4 for priorities and assume 1 is the
highest priority) and Round-Robin scheduling with a given Q parameter.
Compare these scheduling algorithms in terms of average waiting time
on a given sample of processes.
'''
from PCB import *
import pandas as pd

# the implementation of FSFC
def FSFC(queue):
	# set start time =0
	timer=0
	sum_waiting_time=0
	queue_info=queue.get_queue_info() # [self.pid, self.arrival_time, self.burst_time, self.priority, self.state]
	queue_len=queue.get_queue_length()

# creat a {pid:arrival_time} dict and then we can sort them by their arrival time 
	pid_dict={}
	for pid_info in queue_info:
		#[0]-- self.pid  [1]--self.arrival_time
		pid_dict[pid_info[0]]=pid_info[1]
	pid_dict= sorted(pid_dict.items(), key=lambda d: d[1])

	print('\n-------------------------------------------------------------------------------------------------------',end='')
	print('\nUsing FSFC Scheduling, execution sequence is:\n')
	# traverse each process
	for pid in pid_dict:
		node=queue.find_node_by_pid(pid[0]).data
		# if a process added into the queue later
		if node.arrival_time>timer and timer!=0 :
			timer = node.arrival_time
			timer += node.burst_time
		else:
			timer += node.burst_time
		complete_time = timer
		trun_around_time = complete_time - node.arrival_time
		waiting_time = trun_around_time - node.burst_time
		sum_waiting_time += waiting_time

		print('pid:%6d   arrival time:%6d   burst time:%6d   wait time:%6d'\
			%(pid[0],pid[1], node.burst_time,waiting_time))
		queue.delete_node(pid[0])
	print('\nAverage waiting time of FSFC Scheduling:',sum_waiting_time/queue_len)
	print('-------------------------------------------------------------------------------------------------------')



# Non-preemptive Priority scheduling
def non_preemptive(queue):
	# set start time =0
	timer=0
	sum_waiting_time=0
	queue_info=queue.get_queue_info() # [self.pid, self.arrival_time, self.burst_time, self.priority, self.state]
	queue_len=queue.get_queue_length()
	# creat pandas dataframe so that we can sort them by their arrival time and priority
	data=pd.DataFrame(queue_info,columns=['pid', 'arrival_time', 'burst_time','priority', 'state','remaining_time'])
	data = data.sort_values(by=['arrival_time', 'priority'])
	data = data.reset_index(drop=True)

	print('\n-------------------------------------------------------------------------------------------------------',end='')
	print('\nUsing Non-preemptive Priority Scheduling, execution sequence is:\n')
	while len(data)>0:
		# flag is used to save the hightest_priority process
		flag=0
		hightest_priority=99999 #default

		for i in range(len(data)):
			#first dicide if pricess has arrived? 
			# if process has already arrived, search the hightest_priority
			if data.loc[i]['arrival_time']<=timer:
				current_priority=data.loc[i]['priority']
				if current_priority<hightest_priority:
					hightest_priority=current_priority
					flag=i
			# break and excute the hightest_priority process after searched the arrival processes		
			if data.loc[i]['arrival_time']>timer or i==len(data)-1 :
				timer+=data.loc[flag]['burst_time']
				complete_time = timer
				trun_around_time = complete_time - data.loc[flag]['arrival_time']
				waiting_time = trun_around_time - data.loc[flag]['burst_time']
				sum_waiting_time += waiting_time
				# After excuting this process,if next process has not arrived, just wait
				if timer <data.loc[i]['arrival_time']:
					timer=data.loc[i]['arrival_time']

				print('pid:%6d   arrival time:%6d   burst time:%6d   wait time:%6d   priority:%6d'\
					%(data.loc[flag]['pid'],data.loc[flag]['arrival_time'], data.loc[flag]['burst_time'],waiting_time,data.loc[flag]['priority']))
				queue.delete_node(data.loc[flag]['pid'])
				# we need to mantain the dataframe at the same time
				data.drop(flag,axis=0,inplace=True)
				data=data.reset_index(drop=True)
				break

	print('\nAverage waiting time of Non-preemptive Priority Scheduling:',sum_waiting_time/queue_len)
	print('-------------------------------------------------------------------------------------------------------\n')


def round_robin(queue,q):
	# set start time =0
	timer=0
	sum_waiting_time=0
	queue_info=queue.get_queue_info() # [self.pid, self.arrival_time, self.burst_time, self.priority, self.state,self.remaining_time]
	queue_len=queue.get_queue_length()

	# creat pandas dataframe so that we can sort them by their arrival time and priority
	data=pd.DataFrame(queue_info,columns=['pid', 'arrival_time', 'burst_time','priority', 'state','remaining_time'])
	data = data.sort_values(by=['arrival_time'])
	data = data.reset_index(drop=True)
	print(data)

	print('\n-------------------------------------------------------------------------------------------------------',end='')
	print('\nUsing Non-preemptive Priority Scheduling, execution sequence is:\n')
	while len(data)>0:

		for i in range(len(data)):
			pcb= queue.find_node_by_pid(data.loc[i]['pid']).data
			# if all processes has not arrive, just wait
			if timer <data.loc[i]['arrival_time'] and i==0:
				timer=data.loc[i]['arrival_time']

			# if next process has not arrived, just excute the previous process
			if timer <data.loc[i]['arrival_time']:
				i=0
				continue


			if pcb.remaining_time>q:
				timer += q
				pcb.remaining_time -= q
				print('Excute pid:%6d   arrival time:%6d   burst time:%6d   remaining time:%6d   time:%6d'\
					%(data.loc[i]['pid'],data.loc[i]['arrival_time'], data.loc[i]['burst_time'],pcb.remaining_time,timer))

			else:
				timer += pcb.remaining_time
				complete_time = timer
				trun_around_time = complete_time - data.loc[i]['arrival_time']
				waiting_time = trun_around_time - data.loc[i]['burst_time']
				sum_waiting_time += waiting_time
	
				print('\nFinish pid:%6d   arrival time:%6d   burst time:%6d   wait time:%11d   time:%6d'\
					%(data.loc[i]['pid'],data.loc[i]['arrival_time'], data.loc[i]['burst_time'],waiting_time,timer))

				queue.delete_node(data.loc[i]['pid'])
				# we need to mantain the dataframe at the same time
				data.drop(i,axis=0,inplace=True)
				data=data.reset_index(drop=True)	
				break

	print('\nAverage waiting time of Round Robin Priority Scheduling:',sum_waiting_time/queue_len)
	print('-------------------------------------------------------------------------------------------------------\n')