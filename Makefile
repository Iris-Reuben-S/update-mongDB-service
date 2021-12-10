# installer via 'make'
# \author R Sweetman

install:
	@echo Target install
	#install -m 0755 -T update-db.py /usr/local/bin/update-db.py
	install -D -m 0644 update-db.service --target-directory /etc/systemd/system
	install -D -m 0644 update-db.timer --target-directory /etc/systemd/system
	systemctl daemon-reload
	systemctl enable update-db.timer
	systemctl start update-db.timer	
uninstall:
	@echo Target: uninstall
	#rm -f /usr/local/bin/update-db.py
	systemctl stop update-db.timer
	systemctl disable update-db.timer
	rm -f /etc/systemd/system/update-db.timer
	systemctl stop update-db.service
	systemctl disable update-db.service
	rm -f /etc/systemd/system/update-db.service

default: install
