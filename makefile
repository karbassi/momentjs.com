TESTJS = libs/qunit/qunit.js libs/moment/sitesrc/js/unit-tests.js libs/moment/lang/test/*.js
LANGALL = libs/moment/lang/*.js

all: jsmin html css

js:
	git submodule update
	cp libs/moment/moment.js deploy/js/moment.js
	cp libs/moment/moment.min.js deploy/js/moment.min.js
	cat $(TESTJS) > deploy/js/tests.js
	cat $(LANGALL) > deploy/js/langs.js

jsmin: js
	uglifyjs -o deploy/js/langs.min.js deploy/js/langs.js
	uglifyjs -o deploy/js/tests.min.js deploy/js/tests.js
	uglifyjs -o deploy/js/home.min.js source/js/home.js
	uglifyjs -o deploy/js/docs.min.js source/js/docs.js

html:
	node source/build.js

css:
	cleancss -o deploy/css/style.css source/css/style.css