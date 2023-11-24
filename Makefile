all: rotate-all app-deploy

.PHONY: rotate-all
rotate-all: rotate-access-log rotate-slow-log

.PHONY: rotate-access-log
rotate-access-log:
	echo "Rotating access log"
	sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$(shell date +%Y%m%d)
	sudo systemctl restart nginx
	

.PHONY: rotate-slow-log
rotate-slow-log:
	echo "Rotating slow log"
	sudo mv /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$(shell date +%Y%m%d)
	sudo systemctl restart mysql

.PHONY: alp
alp:
	alp json --config ./alp/alp-config.yml

.PHONY: pt
pt:
	sudo pt-query-digest /var/log/mysql/mysql-slow.log


.PHONY: app-deploy
app-deploy:
	echo "Deploying app"
	cd /home/isucon/webapp/go && go build -o isuconquest
	sudo systemctl stop isuconquest.go.service
	sudo systemctl disable isuconquest.go.service
	sudo systemctl start isuconquest.go.service
	sudo systemctl enable isuconquest.go.service	
