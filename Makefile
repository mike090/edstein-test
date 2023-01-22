setup:
	cp -n .env.example .env || true
	bin/setup

start:
	bin/rails s -p 3000 -b "localhost"

test:
	bundle exec rspec

lint:
	bundle exec rubocop

check: lint test

.PHONY: test
