obj-m = hello.o
KVERSION = $(shell uname -r)
all:
	make -C /lib/modules/$(KVERSION)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(KVERSION)/build M=$(PWD) clean

run: 
	sudo insmod hello.ko
	sudo lsmod | less
	sudo tail -f /var/log/kern.log
	sudo rmmod hello
		

