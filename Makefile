all: status

deploy:
	./deploy.sh

status:
	git status

add:
	git add .

commit: add
	git commit -m 'modify'

pull:
	git pull

push:
	git push -u origin master

commit-push: commit push
