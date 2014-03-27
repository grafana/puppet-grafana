.PHONY: all
all: Gemfile.lock
	for m in `find manifests -name \*.pp`; do echo $$m; \
	    bundle exec puppet-lint $$m || r=1; \
	    bundle exec puppet parser validate $$m || r=1; \
	done; exit $$r

Gemfile.lock:
	bundle install
