
build:
	jekyll build

deploy:
	jekyll build
	git add -A
	git commit -am 'jekyll build'
	git push origin gh-pages

server:
	jekyll s
